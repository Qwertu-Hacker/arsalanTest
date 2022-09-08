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
    @Published var didAuthenticateUser = false
    @Published var currentUser: Usert?
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("lala - \(self.userSession?.uid)")
        self.fetchUser()
    }
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debug: Feiled to register \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debug: Feiled to register \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.tempUserSession = user
           
            
            let data = ["email" : email, "username" : username.lowercased(), "fullname" : fullname, "uid" : user.uid, "password" : password]
                
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { result in
                        
                    print("Send data\(data)")
                    self.didAuthenticateUser = true
            }
        }
    }
    func signOut() {
        // sets user session to nil so we show login view
        userSession = nil
        // sign user out on server
        try? Auth.auth().signOut()
        
    }
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }

            service.fetchUser(withUid: uid) { user in
                self.currentUser = user
        }
    }
}
