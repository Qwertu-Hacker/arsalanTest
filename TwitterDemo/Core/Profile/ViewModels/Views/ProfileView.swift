//
//  ProfileView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var selectionFilter: TweetFilterViewModel = .tweets
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    
    init(user: Usert) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            headerView
            
            actionButtons
            
            userInfoDetails
            
            tweetFilterBar
            
            tweetsView
            
            Spacer()

        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: Usert(id: NSUUID().uuidString,
                                namea: "batman",
                                fullnamea: "Bruce Vaine",
                                emaila: "batman@gmail.com",
                                passworda: "",
                                profileImageUrla: ""))
    }
}

extension ProfileView {
    
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: 0)
                }
                KFImage(URL(string: viewModel.user.profileImageUrla))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                .frame(width: 72, height: 72)
                .offset(x: 16, y: 24)
            }
        }
        .frame(height:100)
    }
    var actionButtons: some View {
        HStack {
            Spacer()
            Image(systemName: "bell.badge")
            .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray,    lineWidth: 1))
        
            Button {
            
            } label: {
                Text("Edit Profile")
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius:     20).stroke(Color.gray, lineWidth: 1))
            }
        
        }
        .padding(.trailing)
    
    }
    var userInfoDetails: some View {
    VStack(alignment: .leading, spacing: 4) {
        HStack {
            Text(viewModel.user.fullnamea)
                .font(.title2).bold()
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(Color(.systemBlue))
        }
        
        Text("@\(viewModel.user.namea)")
            .font(.subheadline)
            .foregroundColor(.gray)
        
        Text("Your moms favorit villain")
            .font(.subheadline)
            .padding(.vertical)
        
        HStack(spacing: 24) {
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
            
                Text("Gothom NY")
            }
        
            HStack {
                Image(systemName: "link")
            
                Text("www.thejoker.com")
            }
        }
        .font(.caption)
        .foregroundColor(.gray)
        
        UserStatsView()
        .padding(.vertical)
        }
    .padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectionFilter == item ? .semibold : .regular)
                        .foregroundColor(selectionFilter == item ? .black : .gray)
                    if selectionFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectionFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x:0, y:16))
    }
    var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.tweets, id: \.self) { tweet in
                    TweetRowView(tweet: tweet)
                        .padding()
                }
            }
        }
    }
}
