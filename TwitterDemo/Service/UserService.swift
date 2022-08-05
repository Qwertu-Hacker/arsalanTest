//
//  UserServis.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 31.07.2022.
//

import Firebase
import FirebaseFirestoreSwift

// возвращает дикшенери даных того юзера который заходит [пароль, имя, картинку, емаил, фамилию]
struct UserService {
    
    
     func fetchUser(withUid uid: String, complitionHandler: @escaping (Usert) -> Void) {
         Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
               
                guard let user = try? snapshot.data() else { return }
//                print("frfrfr \(user)")
                let idUser = user["uid", default: "Uncknown"]
                let theuserUsername = user["username", default: "Uncknown"]
                let theuserFullname = user["fullname", default: "Uncknown"]
                let theuserEmail = user["email", default: "Uncknown"]
                let theuserPassword = user["password", default: "Uncknown"]
                let theuserProfileImageUrl = user["profileImageUrl", default: "Uncknown"]
                let usert = Usert(id: idUser as? String,namea: theuserUsername as! String, fullnamea: theuserFullname as! String, emaila: theuserEmail as! String, passworda: theuserPassword as! String, profileImageUrla: theuserProfileImageUrl as! String)
                
                complitionHandler(usert)
        }
    }
    
    func fetchUsers(complitionHandler: @escaping ([Usert]) -> Void) {
        var users = [Usert]()
        
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                
                guard let documents = snapshot?.documents else { return }
                documents.forEach { document in
                    guard let user = try? document.data() else { return }
                    let idUser = user["uid", default: "Uncknown"]
                    let theuserUsername = user["username", default: "Uncknown"]
                    let theuserFullname = user["fullname", default: "Uncknown"]
                    let theuserEmail = user["email", default: "Uncknown"]
                    let theuserPassword = user["password", default: "Uncknown"]
                    let theuserProfileImageUrl = user["profileImageUrl", default: "Uncknown"]
                    
                    let usert = Usert(id: idUser as? String,namea: theuserUsername as! String, fullnamea: theuserFullname as! String, emaila: theuserEmail as! String, passworda: theuserPassword as! String, profileImageUrla: theuserProfileImageUrl as! String)
                    users.append(usert)
                    
                    
                }
//                print("frfrfr: \(users)")
                complitionHandler(users)
                
            }
    }
}
