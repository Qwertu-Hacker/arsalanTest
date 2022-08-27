//
//  NewMessage.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 09.08.2022.
//

import SwiftUI

struct NewMessage: View {
    @ObservedObject var viewModel = ExploreViewModel()
    @Environment(\.presentationMode) var mode
    var body: some View {
        NavigationView{
        VStack{
            HStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .foregroundColor(Color.red)
                            .offset(x: 16, y: 0)
                }
                Spacer()
    
            }
            .padding(.leading)
            
                ScrollView {
                    SerchBar(text: $viewModel.serchText)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .frame(height: 20)
                        .padding()
                    LazyVStack {
                        ForEach(viewModel.serchableUsers) { user in
                            NavigationLink {
                                MessagesView(user: user)
                            } label: {
                                UserRowView(user: user)
                                
                            
                            }
                        }
                    }
                }
            }
        .navigationBarHidden(true)
        }
    }
}

struct NewMessage_Previews: PreviewProvider {
    static var previews: some View {
        NewMessage()
    }
}
