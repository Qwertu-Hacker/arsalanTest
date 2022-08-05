//
//  ProfileViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 04.08.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweett]()
    private let service = TweetService()
     let user: Usert
    
    init(user: Usert) {
        self.user = user
        self.fetchUserTweets()
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
}
