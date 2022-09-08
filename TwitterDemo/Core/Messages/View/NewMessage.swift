//
//  NewMessage.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 09.08.2022.
//

import SwiftUI

struct NewMessage: View {
    @ObservedObject var viewModel = ExploreViewModel()
    var body: some View {
        VStack{
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
    }
}

struct NewMessage_Previews: PreviewProvider {
    static var previews: some View {
        NewMessage()
    }
}
