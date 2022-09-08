//
//  ChatRowMessage.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 17.08.2022.
//
import Foundation
import FirebaseFirestoreSwift
import Firebase

struct ChatRowMessages: Identifiable, Decodable {
    
    @DocumentID var id: String?
    
    let fromId: String
    let toId: String
    let text: String
    let timestamp: Date

//    var hasUnreadMessage = false
    var user: Usert?
    
    var timeAgo: String {
        let formater = RelativeDateTimeFormatter()
        formater.dateTimeStyle = .numeric
        return formater.localizedString(for: timestamp, relativeTo: Date())
    }
    
}
