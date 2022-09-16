//
//  SideMenuViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 25.07.2022.
//

import Foundation


enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case habit
    case lists
    case bookmarks
    case logout
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .habit: return "Habit"
        case .lists: return "Lists"
        case .bookmarks: return "Bookmarks"
        case .logout: return "Logout"

        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .habit: return "graduationcap.fill"
        case .lists: return "list.bullet"
        case .bookmarks: return "bookmark"
        case .logout: return "arrow.left.square"

        }
    }
}
