//
//  ItemActionTableViewDelegate.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

/// A type that should be configured with some data.
protocol Configurable {
    /// Configures the object with the data.
    func configure(for value: ValueType)
    associatedtype ValueType
}
