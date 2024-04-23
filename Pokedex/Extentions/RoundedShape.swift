//
//  RoundedShape.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import Foundation
import UIKit
import SwiftUI

struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 20, height: 20))
        return Path(path.cgPath)
    }
}
