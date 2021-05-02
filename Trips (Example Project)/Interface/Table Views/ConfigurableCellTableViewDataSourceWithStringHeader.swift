//
//  ConfigurableCellTableViewDataSourceWithStringHeader.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

typealias DequeueableConfigurableTableViewCell = UITableViewCell & DequeuableTableViewCell & Configurable

/// Provides sections and their configured cells to a single table view.
///
/// Cells are automatically registered for reuse in the initialiser,
/// and dequeued and configured when requested by the table view.
final class ConfigurableCellTableViewDataSourceWithStringHeader<CellType: DequeueableConfigurableTableViewCell>: NSObject, UITableViewDataSource {

    typealias CellValueType = TableViewTitledSection<CellType.ValueType>

    var data: [CellValueType]

    /**
        - parameter data: a nested array containing data, where the top-level array describe sections, and the secondary arrays describe
        - parameter tableView: the `UITableView` instance this object will provide data to. Reuse will automatically be configured with this table view.
     */
    init(data: [CellValueType], tableView: UITableView) {
        self.data = data
        CellType.registerForReuse(in: tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CellType.dequeue(for: tableView, at: indexPath)
        cell.configure(for: data[indexPath.section].rows[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].title
    }
}
