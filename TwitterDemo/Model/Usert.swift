//
//  File.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 31.07.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Usert: Identifiable, Decodable {
    @DocumentID var id: String?
    var username: String
    var fullname: String
    var profileImageUrl: String
    var email: String
    var password: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
   
}

