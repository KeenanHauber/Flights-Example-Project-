//
//  NavigationPushRouter.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

struct NavigationPushRouter {
    let navigationViewController: UINavigationController

    func route(toSceneFor flight: Flight) {
        let viewController = TicketViewController()
        let presenter = TicketDataPresenter(ticketDisplay: viewController)
        presenter.present(flight: flight)
        viewController.title = "Trips"
        navigationViewController.pushViewController(viewController, animated: true)
    }
}
