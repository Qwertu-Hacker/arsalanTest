//
//  TweetRowView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @State private var goToProfile = false
    @ObservedObject var viewModel: TweetRowViewModel
    init(tweet: Tweett) {
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.tweet.user.self {
                
                HStack(alignment: .top, spacing: 12) {
                    Button {
                        goToProfile.toggle()
                    } label: {
                        
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                    }
                    .fullScreenCover(isPresented: $goToProfile) {
                        ProfileView(user: user)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(user.fullname)
                                    .font(.subheadline).bold()
                                Text("@\(user.username)")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                
                                Spacer()
                                
                                Text(viewModel.tweet.timestamp.dateValue().formatted(date: Date.FormatStyle.DateStyle.omitted, time: Date.FormatStyle.TimeStyle.shortened))
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            
                        }
                        Text(viewModel.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            // action buttons
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    viewModel.tweet.didLIke ?? false ? viewModel.unlikeTweet() : viewModel.likeTweet()
                } label: {
                    Image(systemName: viewModel.tweet.didLIke ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didLIke ?? false ? .red : .gray)
                }
                Text("\(viewModel.tweet.likes)")
                 
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding()
            .foregroundColor(.gray)
            Divider()
            
        }
//        .padding()

    }
}

