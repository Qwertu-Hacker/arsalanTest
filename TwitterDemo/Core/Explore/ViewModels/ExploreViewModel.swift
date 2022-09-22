//
//  ExploreViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 02.08.2022.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [Usert]()
    @Published var serchText = ""
    
    var serchableUsers: [Usert] {
        if serchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = serchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    
    let service = UserService()
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
            
//            print("VERTYU : is \(self.users)")
        }
    }
}
