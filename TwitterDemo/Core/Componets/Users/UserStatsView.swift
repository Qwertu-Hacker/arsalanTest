//
//  UserStatsView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 25.07.2022.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing: 24) {
            
            HStack(spacing: 4) {
                Text("807")
                    .font(.subheadline)
                    .bold()
            
                Text("Folowing")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        
            HStack(spacing: 4) {
                Text("6.5M")
                    .font(.subheadline)
                    .bold()
                
                Text("Folowers")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
