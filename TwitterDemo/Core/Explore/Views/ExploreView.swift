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
            VStack {
                SerchBar(text: $viewModel.serchText)
                    .padding()
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.serchableUsers, id: \.self) { user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                UserRowView(user: user)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
