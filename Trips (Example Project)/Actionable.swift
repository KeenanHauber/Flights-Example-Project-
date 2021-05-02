//
//  Actionable.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation

/// A type that has an associated action.
protocol Actionable {
    /// Performs an action linked to the instance.
    var performAssociatedAction: () -> Void { get }
}
