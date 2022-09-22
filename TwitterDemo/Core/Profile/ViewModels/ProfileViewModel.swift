//
//  ProfileViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 04.08.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweett]()
    @Published var likedTweets = [Tweett]()
    
    private let service = TweetService()
    private let userService = UserService()
    
     let user: Usert
    
    init(user: Usert) {
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
    }
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [Tweett] {
        switch filter {
        case .tweets:
            return tweets
        case .repliec:
            return tweets
        case .likes:
            return likedTweets
        }
    }
    
    func fetchUserTweets() {
        guard let uid = user.id else { return }
        service.fetchTweets(forUid: uid) { tweets in
            self.tweets = tweets
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    func fetchLikedTweets() {
        guard let uid = user.id else { return }
        
        service.fetchLikedTweet(forUid: uid) { tweets in
            self.likedTweets = tweets
                    
                    for i in 0 ..< tweets.count {
                        let uid = tweets[i].uid
                                
                        self.userService.fetchUser(withUid: uid) { user in
                            self.likedTweets[i].user = user
                }
            }
        }
    }
}
