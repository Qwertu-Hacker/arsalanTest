//
//  UploadTweetViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 04.08.2022.
//

import Foundation

class UploadTweetViewmodel: ObservableObject {
    @Published var didUploadTweet = false
    let service = TweetService()
    
    func uploadTweet(withCaption caption: String) {
        service.uploadTweet(caption: caption) { success in
            if success {
                self.didUploadTweet = true
            } else {
                
            }
            
        }
    }
}
