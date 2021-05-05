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

        tableViewDataSource = ConfigurableCellTableViewDataSourceWithStringHeader<FlightTableViewCell>(data: data, tableView: contentView)
        contentView.delegate = tableViewDelegate
        contentView.dataSource = tableViewDataSource
    }

    private var data: [TableViewTitledSection<FlightCellData>] = []

    func display(_ data: [TableViewTitledSection<FlightCellData>]) {
        self.data = data

        tableViewDelegate.data = data

        if isViewLoaded {
            tableViewDataSource.data = data
            contentView.reloadData()
        }
    }
}
