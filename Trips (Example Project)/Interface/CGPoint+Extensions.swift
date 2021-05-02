//
//  CGPoint+Extensions.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import CoreGraphics

extension CGPoint {
    /// Returns a translated copy of this point.
    func translated(by x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
}
