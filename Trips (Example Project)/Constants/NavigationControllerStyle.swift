//
//  NavigationControllerStyle.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

/// Styles a `UINavigationBar`.
struct NavigationBarStyle {
    /// The tint color to apply to the navigation bar background.
    let barTintColor: UIColor
    /// The color to apply to the navigation bar's title text.
    let titleColor: UIColor

    /// Applies the style.
    func apply(to navigationBar: UINavigationBar) {
        navigationBar.setTitleTextAttribute(forKey: .foregroundColor, value: titleColor)
        navigationBar.barTintColor = barTintColor
    }

    /// A red bar with a white title.
    static let `default` = NavigationBarStyle(
        barTintColor: ColorAsset.flightCentreRed,
        titleColor: .white
    )
}
