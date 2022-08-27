//
//  MessagesView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//
import Kingfisher
import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var oppenNewMessage = false

    init(user: Usert?) {
        self.viewModel = ChatViewModel(user: user)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Spacer()
                if viewModel.recentMessages.isEmpty {
                
                    Spacer()
                    }
                        
                }
                .offset(y: 300)

                ScrollView {
                    ForEach(viewModel.recentMessages) { recentMessages in
                        VStack {
                            NavigationLink {
                                MessagesView(user: recentMessages.user)
                            } label: {
                                HStack(spacing: 20) {
                                    KFImage(URL(string: recentMessages.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60)
                                    
                                            VStack(alignment: .leading, spacing: 5) {
                                                HStack {
                                                    Text(recentMessages.username )
                                                        .bold()
                                                    Spacer()
                                                    Text(recentMessages.timeAgo)
                                                        .font(.system(size: 14, weight: .semibold))
                                                }
                                                HStack {
                                                    Text(recentMessages.text)
                                                        .foregroundColor(.gray)
                                                        .lineLimit(2)
                                                        .frame(height: 50, alignment: .top)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding(.trailing, 40)
                                                }
//                                                Circle()
//                                                    .foregroundColor(recentMessage.hasUnreadMessage ? .blue: .clear)
//                                                    .frame(width: 18, height: 18, alignment: .trailing)
//                                            }
                                    }
                            }
                            Divider()
                                .offset(x:50)
                                .frame(width: 330)
                                .padding(.vertical, 3)
                            } .padding(.horizontal)
                        
                    
                        }
                    .padding(.bottom)
                
                    }
                }
                }
            .overlay(
                Button {
                    oppenNewMessage.toggle()
                } label: {
                    HStack {
                        Spacer()
                            Text("+ New Message")
                        .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .background(Color.blue)
                    .cornerRadius(32)
                    .padding(.horizontal)
                    .shadow(radius: 15)
                    
            .offset(y: -10)
            }, alignment: .bottom)
        .fullScreenCover(isPresented: $oppenNewMessage) {
            NewMessage()
            }
            .navigationBarTitle("") //this must be empty
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: Usert(username: "bob", fullname: "bob", profileImageUrl: "", email: "@", password: ""))
    }
}