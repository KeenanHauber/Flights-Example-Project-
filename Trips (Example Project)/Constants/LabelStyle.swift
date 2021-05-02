//
//  LabelStyle.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

/// Styles a `UILabel`.
struct LabelStyle {
    /// The color to apply to the label. A nil value will not modify the label.
    let color: UIColor?
    /// The font to apply to the label. A nil value will not modify the label.
    let font: UIFont?

    func apply(to label: UILabel) {
        label.textColor = color ?? label.textColor
        label.font = font ?? label.font
    }

    /// A label style which applies no changes to a label.
    static let `default` = LabelStyle(color: nil, font: nil)
}
