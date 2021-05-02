//
//  ItemActionTableViewDelegate.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

/// Calls the action associated with selected rows.
final class ItemActionTableViewDelegate<SectionType: TableViewSection>: NSObject, UITableViewDelegate where SectionType.DataType: Actionable {

    /**
        - parameter data: a nested array containing data, where the top-level array describe sections, and the secondary arrays describe
     */
    init(data: [SectionType]) {
        self.data = data
    }

    var data: [SectionType]
    /// A block to call on the value associated with a selected cell.
    var action: ((SectionType.DataType) -> ())?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.section].rows[indexPath.row].performAssociatedAction()
    }
}
