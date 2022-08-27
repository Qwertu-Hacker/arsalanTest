//
//  ExploreView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel = ExploreViewModel()
        
    var body: some View {
//        VStack{
            

                ScrollView {
                    SerchBar(text: $viewModel.serchText)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .frame(height: 20)
                        .padding()
                    LazyVStack {
                        ForEach(viewModel.serchableUsers) { user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                UserRowView(user: user)
                            }
                        }
                    }
                }
//        }
//            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Explore")
                        .padding(.top, 10)
                        .font(.headline)
                }
            }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
