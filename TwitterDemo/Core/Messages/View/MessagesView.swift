//
//  MessagesView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 07.08.2022.
//

import SwiftUI
import Kingfisher
import Firebase

struct MessagesView: View {
    @ObservedObject var viewModel: ChatViewModel
    @Environment(\.presentationMode) var mode
    init(user: Usert?) {
        self.viewModel = ChatViewModel(user: user)
    }
    var body: some View {
            VStack {
                ScrollView {
                    ScrollViewReader { proxy in
                        ForEach(viewModel.chatMessages) { message in
                            MessageView(message: message)
                    }
                        // когда отпрявляешь смс
                        .onChange(of: viewModel.chatMessages) { id in
                            withAnimation {
                                proxy.scrollTo(id.last?.id)
                            }
                        }
                        // когда заходишь
                        .onAppear {
                            proxy.scrollTo(viewModel.chatMessages.last?.id, anchor: .bottom)
                        }
                    }
                }
                .background(Color(.init(gray: 0.8, alpha: 1)))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                                    VStack {
                                        Button {
                                        } label: { Text(viewModel.user?.fullname ?? "")
                                        }
                                        .padding(.top).frame(height: 26.0)
                                        .font(.headline)
                                    
                                        Text("Subtitle")
                                            .font(.subheadline)
                                            .padding(.bottom)
                                    }
                    }
                    ToolbarItem(placement:
                            .navigationBarTrailing) {
                                Button {
                                
                                } label: {
                                    KFImage(URL(string: viewModel.user!.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 50, height: 50)
                                        .padding(.bottom)
                                }
                            }
                }
                .padding(.top, 5)
            HStack {
                Image(systemName: "photo.on.rectangle.angled")
                ZStack(alignment: .leading) {
                    if viewModel.chatTexte.isEmpty {
                        Text("Descriptionрп..")
                            .foregroundColor(.black)
                    }
                    TextField("", text: $viewModel.chatTexte)
                }
                .foregroundColor(.black)
                .padding(8)
                .padding(.horizontal, 10)
            .background(Color(.init(gray: 0.8, alpha: 1)))
            .cornerRadius(20)
                
                Button {
                    viewModel.handleChat()
                } label: {
                    Text("Send")
                }
                .font(.headline)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
        }
        
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(user: Usert(id: NSUUID().uuidString,
                                 username: "batman",
                                 fullname: "Bruce Vaine",
                                 profileImageUrl: "",
                                 email: "batman@gmail.com",
                                 password: ""))
            .previewInterfaceOrientation(.portrait)
    }
}



struct MessageView: View {
    let message: ChatMessages
    var body: some View {
        VStack {
            if  message.fromId == Auth.auth().currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(Color.white)
                    }
                    .padding(.vertical, 13)
                    .padding(.horizontal, 13)
                    .background(Color.blue)
                    .cornerRadius(20)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(Color.black)
                    }
                    .padding(.vertical, 13)
                    .padding(.horizontal, 13)
                    .background(Color.white)
                    .cornerRadius(20)
                    Spacer()
                }
            }
        }
        .padding([.top, .leading, .trailing], 10)
    }
}
