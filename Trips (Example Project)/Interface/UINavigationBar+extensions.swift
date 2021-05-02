//
//  UINavigationBar+extensions.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

extension UINavigationBar {
    /// Sets a title text attribute.
    func setTitleTextAttribute(forKey key: NSAttributedString.Key, value: Any) {
        var attributes = titleTextAttributes ?? [:]
        attributes[key] = value
        titleTextAttributes = attributes
    }
}
