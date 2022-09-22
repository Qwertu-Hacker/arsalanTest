//
//  SerchBar.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 03.08.2022.
//

import SwiftUI

struct SerchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(8)
                    })
        }
        .frame(height: 70)
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
}

struct SerchBar_Previews: PreviewProvider {
    static var previews: some View {
        SerchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
