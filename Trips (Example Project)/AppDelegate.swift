//
//  AppDelegate.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 30/4/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var flightDataService: FlightDataService?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationViewController = UINavigationController(rootViewController: ViewController())
        navigationViewController.navigationBar.barTintColor = ColorAsset.flightCentreRed

        let flightDataService = URLFlightDataService(targetURL: APIURL.flightList, downloadService: JSONDownloadTaskService(urlSession: URLSession(configuration: .default)))

        flightDataService.withFlightData(do: { result in
            print(result)
        })

        self.flightDataService = flightDataService

        window.rootViewController = navigationViewController

        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}
