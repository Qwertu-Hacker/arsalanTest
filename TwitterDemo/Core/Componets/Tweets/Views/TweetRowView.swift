//
//  TweetRowView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    let tweet: Tweett
    var body: some View {
        VStack(alignment: .leading) {
            if let user = tweet.user {
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrla))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(user.fullnamea)
                                    .font(.subheadline).bold()
                                Text("@\(user.namea)")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                
                                Text("2w")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            
                        }
                        Text(tweet.caption)
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
                    
                } label: {
                    Image(systemName: "heart")
                        .font(.subheadline)
                }
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

