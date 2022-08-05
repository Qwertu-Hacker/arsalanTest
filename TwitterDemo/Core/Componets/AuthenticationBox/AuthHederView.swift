//
//  AuthenticationHederView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 27.07.2022.
//

import SwiftUI

struct AuthHederView: View {
    var title1: String
    var title2: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack { Spacer() }
            
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(RoundedShape(coners: [.bottomRight]))
    }
}

struct AuthHederView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHederView(title1: "Hello.", title2: "lol")
    }
}
