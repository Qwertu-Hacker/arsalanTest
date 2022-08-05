//
//  File.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 31.07.2022.
//

import FirebaseFirestoreSwift

    
struct Usert: Hashable, Identifiable, Decodable {
    
    @DocumentID var id: String?
        var namea: String
        var fullnamea: String
        var emaila: String
        var passworda: String
        var profileImageUrla: String

    
}

