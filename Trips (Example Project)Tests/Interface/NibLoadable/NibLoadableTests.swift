//
//  NibLoadableTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 4/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class NibLoadableTests: XCTestCase {
    func test_loadFromNib() {
        let view = TestNibLoadableView.loadFromNib()
        expect(view.loadedFromNibCalled, toEqual: true)
    }
}
