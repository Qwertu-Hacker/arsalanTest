//
//  TweetRowViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 04.08.2022.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweett
    private let service = TweetService()
    
    
    init(tweet: Tweett) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        service.likeTweet(tweet) {
            self.tweet.didLIke = true
        }
    }
    func unlikeTweet() {
        service.unlikeTweet(tweet) {
            self.tweet.didLIke = false 
        }
    }
    func checkIfUserLikedTweet() {
        service.checkIfUserLikedTweet(tweet) { didLike in
            if didLike {
                self.tweet.didLIke = true
            }
        }
    }
}
