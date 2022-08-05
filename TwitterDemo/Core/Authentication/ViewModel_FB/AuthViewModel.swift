//
//  AuthViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 27.07.2022.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
}
