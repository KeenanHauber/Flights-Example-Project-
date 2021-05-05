//
//  DequeueableCell.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

// TODO: Test

/// A table view cell that may be registered for reuse.
protocol DequeuableTableViewCell {
    /// The reuse identifier for the cell.
    static var reuseIdentifier: String { get }
    /// Dequeues a cell from a table view.
    static func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> Self
    /// Registers a
    static func registerForReuse(in tableView: UITableView)
}

extension DequeuableTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> Self {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: Self.reuseIdentifier, for: indexPath) as? Self else {
            fatalError("Could not dequeue cell from table view: has the correct type been registered?")
        }
        return cell
    }
}

extension DequeuableTableViewCell where Self: NibLoadable {
    static func registerForReuse(in tableView: UITableView) {
        tableView.register(Self.nib, forCellReuseIdentifier: Self.reuseIdentifier)
    }
}
