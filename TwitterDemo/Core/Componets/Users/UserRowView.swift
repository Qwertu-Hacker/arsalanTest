//
//  UserRowView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 24.07.2022.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    
    let user: Usert
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullname)
                    .font(.subheadline).bold()
                
                Text(user.username)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()

        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
    
}



