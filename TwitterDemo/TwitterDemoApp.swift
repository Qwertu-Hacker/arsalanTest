//
//  TwitterDemoApp.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//

import SwiftUI
import Firebase

@main
struct TwitterDemoApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(viewModel)

        }
    }
}
