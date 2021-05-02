//
//  ViewController.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 30/4/21.
//

import UIKit

protocol TicketDisplay: AnyObject {
    func configure(for data: TicketViewData)
}

/// A view controller displaying information about a flight (and ticket information).
final class TicketViewController: UIViewController, TicketDisplay {

    // MARK: - Data

    private(set) var ticketViewData: TicketViewData?

    /// Sets the information displayed in the ticket view.
    func configure(for data: TicketViewData) {
        ticketView?.configure(for: data)
        self.ticketViewData = data
    }

    // MARK: - Subviews

    var ticketView: TicketView?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let ticketView = TicketView.loadFromNib()
        view.addSubview(ticketView)

        ticketView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        ticketView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        ticketView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true

        if let ticketViewData = ticketViewData {
            ticketView.configure(for: ticketViewData)
        }
    }
}
