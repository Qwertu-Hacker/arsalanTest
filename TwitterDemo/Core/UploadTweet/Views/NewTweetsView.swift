//
//  NewTweetsView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 25.07.2022.
//

import SwiftUI
import Kingfisher

struct NewTweetsView: View {
    @State private var caption = ""
    // для кнопки кенсел
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadTweetViewmodel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                Spacer()
                
                Button {
                    viewModel.uploadTweet(withCaption: caption)
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                }
                
            }
            .padding()
            
            HStack(alignment: .top) {
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                }
                TextArea("Write the text..", text: $caption)
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadTweet) { seccess in
            if seccess {
                presentationMode.wrappedValue.dismiss()     
            }
        }
    }
}

struct NewTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetsView()
    }
}
