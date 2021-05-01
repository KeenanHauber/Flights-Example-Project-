//
//  ColorAssetTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class ColorAssetTests: XCTestCase {

    /// Ensures the presence of all color assets.
    func test_colorAssets() {
        failIfAbsent(ColorAsset.flightCentreBlue)
        failIfAbsent(ColorAsset.flightCentreRed)
        failIfAbsent(ColorAsset.primaryGrey)
        failIfAbsent(ColorAsset.secondaryGrey)
    }
}
