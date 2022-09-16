//
//  SideMenuView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 25.07.2022.
//

import SwiftUI
import Kingfisher


struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var shouldShowLoginOptions = false
    var body: some View {
        
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    UserStatsView()
                        .padding(.vertical)
                }
                .padding(.leading)
                // ForEach для енума
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
                    if viewModel == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                            }
                        }
                    else if viewModel == .habit {
                        NavigationLink {
                            Habitt()
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                    } else if viewModel == .logout {
                        Button {
                            shouldShowLoginOptions.toggle()
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                        .actionSheet(isPresented: $shouldShowLoginOptions ) {
                            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [.destructive(Text("Sing Out"), action: {
                                authViewModel.signOut()
                            }),
                                .cancel()
                             ])
                        }
                    } else {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
