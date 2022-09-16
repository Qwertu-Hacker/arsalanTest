//
//  ContentView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
        Group {
            // no user loggen in
            if viewModel.userSession == nil {
                LoginView()
            } else {
                // have a logged in user
                mainInterfaceView
                }
            }
        }
        .navigationBarHidden(true)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//            ContentView()
//    }
//}

extension ContentView {
    var mainInterfaceView: some View {
        
        ZStack(alignment: .topLeading) {
            MainTabView()
                .navigationBarHidden(showMenu)
            
            if showMenu {
                ZStack {
                    Color(.black)
                    // прозрачность
                        .opacity(showMenu ? 0.25 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeInOut) {
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            SideMenuView()
                .frame(width: 300)
                .offset(x: showMenu ? 0 : -300, y: 0)
                .background(showMenu ? Color.white : Color.clear)
        }
//        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: "tornado")
                        .foregroundColor(Color.blue)
                        .frame(width: 50, height: 50)
                }
               ToolbarItem(placement: .navigationBarLeading) {
                    if let user = viewModel.currentUser {
                        Button {
                            withAnimation(.easeInOut) {
                            showMenu.toggle()
                            }
                        } label: {
                            KFImage(URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                            
                            Text("@\(user.username)")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
            }
            .padding(.top, 5)
    .onAppear {
        showMenu = false
        }
    }
}
