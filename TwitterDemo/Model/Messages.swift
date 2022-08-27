//
//  File.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 12.08.2022.
//
import FirebaseFirestoreSwift
import Firebase


struct ChatMessages : Identifiable , Decodable{
    
    @DocumentID var id: String?

    let fromId: String
    let toId: String
    let text: String
    let timestamp: Timestamp
}

