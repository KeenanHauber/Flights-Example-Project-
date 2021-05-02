//
//  NibLoadable.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import UIKit

/// Describes  an object that may be loaded from a Nib.
///
/// By default, the type's name will be used as the name of the nib,
/// and it will be assumed that the
protocol NibLoadable {
    /// Loads the object from a nib.
    ///
    /// By default this attempts an unsafe load of the first object in the nib.
    static func loadFromNib() -> Self
    /// The name of the nib describing the type.
    ///
    /// By default this is the nib with the same name as the type.
    static var nib: UINib { get }
    /// Called directly after the object has been loaded from the nib.
    func loadedFromNib()
}

extension NibLoadable {
    func loadedFromNib() {}
}

extension NibLoadable where Self: AnyObject {
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle(for: Self.self))
    }

    static func loadFromNib() -> Self {
        let nib = self.nib
        let array = nib.instantiate(withOwner: nil, options: nil)
        guard let object = array.first else {
            fatalError("Failed to load object from nib for type \(Self.self): no object in nib!")
        }
        guard let typedObject = object as? Self else {
            fatalError("Failed to load object from nib: expected type \(Self.self)!")
        }

        typedObject.loadedFromNib()

        return typedObject
    }
}
