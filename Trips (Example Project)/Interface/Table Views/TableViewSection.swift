//
//  TableViewSection.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation

/// Describes a section in a table view.
protocol TableViewSection {
    var rows: [DataType] { get }
    associatedtype DataType
}

/// Describes a titled section in a table view.
class TableViewTitledSection<DataType>: TableViewSection {
    /// The section's human-readable title.
    let title: String
    /// The section's row data.
    var rows: [DataType]

    init(title: String, rows: [DataType]) {
        self.title = title
        self.rows = rows
    }

    /// Returns a titled section with the transformed rows.
    func mapRows<NewDataType>(_ transform: (DataType) throws -> NewDataType) rethrows -> TableViewTitledSection<NewDataType> {
        return TableViewTitledSection<NewDataType>(
            title: title,
            rows: try rows.map(transform)
        )
    }

    /// Groups an array into titled sections.
    ///
    /// Note this does not sort the array before grouping.
    static func groupArrayIntoSections(_ array: [DataType], titleForItem: (DataType) -> String) -> [TableViewTitledSection<DataType>] {
        var sections: [TableViewTitledSection<DataType>] = []
        for item in array {
            let title = titleForItem(item)
            if let section = sections.last,
               section.title == title {
                section.rows.append(item)
            } else {
                sections.append(TableViewTitledSection<DataType>(title: title, rows: [item]))
            }
        }
        return sections
    }
}

