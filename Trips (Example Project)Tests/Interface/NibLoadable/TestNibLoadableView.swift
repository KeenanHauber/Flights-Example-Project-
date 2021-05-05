//
//  DummyView.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 4/5/21.
//

import UIKit
@testable import Trips__Example_Project_

final class TestNibLoadableView: UIView, NibLoadable {
    var loadedFromNibCalled = false

    func loadedFromNib() {
        loadedFromNibCalled = true
    }
}
