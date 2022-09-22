//
//  UserServis.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 31.07.2022.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    
     func fetchUser(withUid uid: String, complitionHandler: @escaping (Usert) -> Void) {
         Firestore.firestore().collection("users")
            .document(uid)
            .addSnapshotListener { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: Usert.self) else { return }
                complitionHandler(user)
        }
    }
    
    func fetchUsers(complitionHandler: @escaping ([Usert]) -> Void) {
        
        Firestore.firestore().collection("users")
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: Usert.self)})
                complitionHandler(users)
                
        }
    }
}
