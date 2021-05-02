//
//  FlightInfoView.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

class FlightInfoView: UIView, NibLoadable {
    /// Displays the title of the view.
    ///
    /// Use `setTitle(_:)` to automatically format the title.
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    func setTitle(_ title: String) {
        titleLabel.text = "\(title) :"
    }
}
