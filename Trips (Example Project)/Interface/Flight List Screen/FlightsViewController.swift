//
//  FlightsViewController.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

/// Displays a list of flights.
protocol FlightsDisplay: AnyObject {
    func display(_ flightCellData: [TableViewTitledSection<FlightCellData>])
}

/// A view controller containing a table view showing a list of flights.
final class FlightsViewController: UIViewController, FlightsDisplay {

    @IBOutlet weak var contentView: UITableView!

    var tableViewDataSource: ConfigurableCellTableViewDataSourceWithStringHeader<FlightTableViewCell>!
    let tableViewDelegate = ItemActionTableViewDelegate<TableViewTitledSection<FlightCellData>>(data: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewDataSource = ConfigurableCellTableViewDataSourceWithStringHeader<FlightTableViewCell>(data: [], tableView: contentView)
        contentView.delegate = tableViewDelegate
        contentView.dataSource = tableViewDataSource
    }

    func display(_ data: [TableViewTitledSection<FlightCellData>]) {
        tableViewDataSource.data = data
        tableViewDelegate.data = data

        contentView.reloadData()
    }
}
