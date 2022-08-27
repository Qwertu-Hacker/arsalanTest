//
//  PerehodNaUsera.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 25.08.2022.
//
//import Firebase
//
//import Foundation
//
//struct PerehodNaUsera {
//
//    func fetchRecentMessages(fromId: String, complition: @escaping([ChatRowMessages]) -> Void) {
//
//           Firestore.firestore().collection("recent_messages")
//                .document(fromId)
//                .collection("messages")
//                .whereField("fromId", isEqualTo: fromId)
//
//                .getDocuments { snapshot, error in
//                    if let error = error {
//                        print(error)
//                        return
//                    }
//                    guard let documents = snapshot?.documents else { return }
//
//                    let recentMessages = documents.compactMap({try? $0.data(as: ChatRowMessages.self)})
//                    complition(recentMessages.sorted(by: { $0.timestamp > $1.timestamp}))
//
//                }
//            }
//}
