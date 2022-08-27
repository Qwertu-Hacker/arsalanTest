//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 04.08.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweett: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: Usert?
    var didLIke: Bool? = false
    
}
