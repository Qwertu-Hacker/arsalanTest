//
//  PolsovatelViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 25.08.2022.
//
//import Foundation
//
//
//class PolsovatelViewModel: ObservableObject {
//    
//    @Published var recentMessages = [ChatRowMessages]()
//    var service = PerehodNaUsera()
//    let userService = UserService()
//    
//    init() {
//        fetchRecentMessages()
//    }
//    
//    func fetchRecentMessages() {
//        service.fetchRecentMessages { polsovotel in
//            self.recentMessages = polsovotel
//            
//            for i in 0 ..< recentMessages.count {
//                let fromId = recentMessages[i].fromId
//                        
//                self.userService.fetchUser(withUid: fromId) { user in
//                    self.recentMessages[i].user = user
//                }
//            }
//        }
//    }
//
//}
