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
        
        
        let data = ["id" : "\(UUID())",
                    "uid": uid,
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
        var tweets = [Tweett]()
            Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                documents.forEach { doc in
                    guard let tweet = try? doc.data() else { return }
                    print("frfrfr: data is : \(doc.data())")
                    let tweetId = tweet["id", default: "Uncknown"]
                    let captionTweet = tweet["caption", default: "Uncknown"]
                    let timestampTweet = tweet["timestamp", default: "Uncknown"]
                    let uidTweet = tweet["uid", default: "Uncknown"]
                    var likesTweet = tweet["likes", default: "Uncknown"]
                    
                    var tweett = Tweett(id: tweetId as! String, caption: captionTweet as! String, timestamp: timestampTweet as! Timestamp, uid: uidTweet as! String, likes: likesTweet as! Int)
                    tweets.append(tweett)
            }
                complition(tweets)
        }
    }
    func fetchTweets(forUid uid: String, complition: @escaping([Tweett]) -> Void) {
        var tweets = [Tweett]()
            Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                documents.forEach { doc in
                    guard let tweet = try? doc.data() else { return }
                    let tweetId = tweet["id", default: "Uncknown"]
                    let captionTweet = tweet["caption", default: "Uncknown"]
                    let timestampTweet = tweet["timestamp", default: "Uncknown"]
                    let uidTweet = tweet["uid", default: "Uncknown"]
                    var likesTweet = tweet["likes", default: "Uncknown"]
                    
                    var tweett = Tweett(id: tweetId as! String, caption: captionTweet as! String, timestamp: timestampTweet as! Timestamp, uid: uidTweet as! String, likes: likesTweet as! Int)
                    tweets.append(tweett)
            }
                complition(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()}))
        }
    }
    func likeTweet(_ tweet: Tweett) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        
        
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes + 1]) { _ in
            
            
            userLikesRef.document(tweetId).setData([:]) { _ in
                print("frfrfr: \(tweetId)")
            }
        }
    }
}

