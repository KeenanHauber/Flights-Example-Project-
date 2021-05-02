//
//  ViewController.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 30/4/21.
//

import UIKit

class ViewController: UIViewController {

    var ticketView: TicketView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let ticketView = TicketView.loadFromNib()

        view.addSubview(ticketView)

        // Background color to make ticketView visible without shadow
//        view.backgroundColor = .black

        ticketView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        ticketView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        ticketView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
}
