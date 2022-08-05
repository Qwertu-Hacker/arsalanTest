//
//  TweetFilterViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 24.07.2022.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets
    case repliec
    case likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .repliec: return "Repliec"
        case .likes: return "Likes"

        }
    }
}
