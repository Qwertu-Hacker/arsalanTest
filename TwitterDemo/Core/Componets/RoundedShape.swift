//
//  RoundedShape.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 27.07.2022.
//

import SwiftUI

struct RoundedShape: Shape {
    var coners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: coners, cornerRadii: CGSize(width: 80, height: 80))
        
        return Path(path.cgPath)
    }
}
