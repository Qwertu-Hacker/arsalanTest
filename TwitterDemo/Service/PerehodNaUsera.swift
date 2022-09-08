//
//  PerehodNaUsera.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 25.08.2022.

import Firebase
import Foundation

struct PerehodNaUsera {
    

    func fetchRecentMessages(forUid fromId: String,complition: @escaping([ChatRowMessages]) -> Void) {

        Firestore.firestore().collection("recent_messages")
            .document(fromId)
            .collection("messages")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }
                let recentMessages = documents.compactMap { document -> ChatRowMessages? in
                    return try? document.data(as: ChatRowMessages.self)
                }
                complition(recentMessages.sorted(by: { $0.timestamp > $1.timestamp }))
            }
    }
}
