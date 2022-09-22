//
//  InHabitViewModel.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 19.09.2022.
//

import SwiftUI

class InHabitViewModel: NSObject, ObservableObject {
    @Published var progress: CGFloat = 1
    @Published var timerString = "00:00"
    @Published var hour = 0
    @Published var minute = 0
    @Published var second = 0
    @Published var isStarted = false
    @Published var addNewTimer = false
}
