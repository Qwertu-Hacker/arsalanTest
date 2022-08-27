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
            .getDocument { snapshot, _ in
                print("lalal")
                guard let snapshot = snapshot else { return }
                print("lalal2")
                guard let user = try? snapshot.data(as: Usert.self) else { return }
                print("lalal3")
                complitionHandler(user)
                print("lalal \(user.username)")
        }
    }
    
    func fetchUsers(complitionHandler: @escaping ([Usert]) -> Void) {
        
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: Usert.self)})
                print("frfrfr : :")
                complitionHandler(users)
                
        }
    }
}
