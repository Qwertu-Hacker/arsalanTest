//
//  TweetService.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 04.08.2022.
//

import Firebase

struct TweetService {
    func uploadTweet(caption : String, complition: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any] 
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    print("VERTYU: Feiled ti up tweet \(error.localizedDescription)")
                    complition(false)
                    return
                }
                complition(true)
            }
        }
    func fetchTweets(complition: @escaping([Tweett]) -> Void) {
            Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let tweets = documents.compactMap({try? $0.data(as: Tweett.self)})
                complition(tweets)
//                print("lalalal - \(tweets)")
        }
    }
    func fetchTweets(forUid uid: String, complition: @escaping([Tweett]) -> Void) {
            Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let tweets = documents.compactMap({try? $0.data(as: Tweett.self)})
                complition(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()}))
        }
    }
}
// MARK: - Likes
extension TweetService {
    func likeTweet(_ tweet: Tweett, complition: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes + 1]) { _ in
            userLikesRef.document(tweetId).setData([:]) { _ in
                complition()
            }
        }
    }
    func unlikeTweet(_ tweet: Tweett, complition: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes - 1]) { _ in
                userLikesRef.document(tweetId).delete() { _ in
                complition()
            }
        }
    }
    func checkIfUserLikedTweet(_ tweet: Tweett, complition: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                complition(snapshot.exists)
        }
    }
    func fetchLikedTweet(forUid uid: String, competition: @escaping([Tweett]) -> Void) {
        var tweets = [Tweett]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweett.self) else { return }
                            tweets.append(tweet)
                            
                            competition(tweets)
                }
            }
        }
    }
}
