//
//  TweetRowViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 04.08.2022.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    let tweet: Tweett
    private let service = TweetService()
    
    
    init(tweet: Tweett) {
        self.tweet = tweet
    }
    
    func likeTweet() {
        service.likeTweet(tweet)
    }
}
