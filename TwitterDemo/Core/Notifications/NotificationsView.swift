//
//  NotificationsView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 23.07.2022.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
        Text("NotificationsView")
        }
        
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
