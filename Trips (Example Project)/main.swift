//
//  main.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

func delegateClassName() -> String? {
    // Prevent the AppDelegate from being instantiated when running unit tests.
    if NSClassFromString("XCTestCase") != nil {
        return nil
    } else {
        // If not running unit tests, allow AppDelegate instantiation
        return NSStringFromClass(AppDelegate.self)
    }
}

_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, delegateClassName())
