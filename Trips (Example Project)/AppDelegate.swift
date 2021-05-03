//
//  AppDelegate.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 30/4/21.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let flightDataService = URLFlightDataService(
        targetURL: APIURL.flightList,
        downloadService: JSONDownloadTaskService(urlSession: URLSession(configuration: .default))
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)

        let flightsViewController = FlightsViewController()
        flightsViewController.title = "Trips"

        let navigationViewController = UINavigationController(rootViewController: flightsViewController)
        NavigationBarStyle.default.apply(to: navigationViewController.navigationBar)

        flightDataService.withFlightData(do: { result in
            if case let .success(data) = result {
                FlightsPresenter(
                    flightsDisplay: flightsViewController,
                    formatter: FlightToFlightCellDataMapper(timeFormatter: CustomDateFormatter.timeFormatter24hour)
                ).present(
                    flights: data,
                    actionForFlight: { flight in
                        return {
                            NavigationPushRouter(navigationViewController: navigationViewController).route(toSceneFor: flight)
                        }
                    }
                )
            }
        })

        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
