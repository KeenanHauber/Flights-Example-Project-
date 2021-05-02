//
//  TicketView.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 30/4/21.
//

import UIKit

class TicketView: UIView, NibLoadable {

    let shapeMask = CAShapeLayer()

    static let cutoutRadius: CGFloat = 20
    static let cornerRadius: CGFloat = 5

    /// Provides masking for sub-content
    @IBOutlet weak var _maskView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var dividingLine: DividingLine!
    @IBOutlet weak var qrCodeView: UIImageView!

    let flightAirportView = FlightAirportsView.loadFromNib()

    let flightNumberView = FlightInfoView.loadFromNib()
    let flightGateView = FlightInfoView.loadFromNib()
    let flightTerminalView = FlightInfoView.loadFromNib()
    let flightSeatView = FlightInfoView.loadFromNib()
    @IBOutlet weak var flightInfoStackView: UIStackView!

    func loadedFromNib() {
        flightAirportView.backgroundColor = ColorAsset.flightCentreBlue
        contentStackView.insertArrangedSubview(flightAirportView, at: 0)

        [
            [flightNumberView, flightGateView],
            [flightTerminalView, flightSeatView]
        ].forEach({ row in
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            row.forEach(stackView.addArrangedSubview(_:))
            flightInfoStackView.addArrangedSubview(stackView)
        })


        _maskView.layer.mask = shapeMask
        _maskView.layer.masksToBounds = true

        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 1)

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
    }

    private var maskAdjustedForPreviousBounds: CGRect = .zero
    override func draw(_ rect: CGRect) {

        // Re-calculate mask if bounds have changed
        if maskAdjustedForPreviousBounds != bounds {
            let newPath = CGMutablePath()
            let quarterCircle = CGFloat.pi/2
            let cutoutY = (dividingLine.frame.minY + dividingLine.frame.maxY) / 2

            // Origin is top left corner
            let topLeft = shapeMask.position


            let midTop = topLeft.translated(by: bounds.width / 2, y: 0)
            newPath.move(to: midTop)

            let topLeftCircleCentre = topLeft.translated(by: 5, y: 5)
            newPath.addArc(center: topLeftCircleCentre, radius: TicketView.cornerRadius, startAngle: quarterCircle * 3, endAngle: quarterCircle * 2, clockwise: true)

            // Mid left cutout
            let midLeft = topLeft.translated(by: 0, y: cutoutY)
            newPath.addArc(center: midLeft, radius: TicketView.cutoutRadius, startAngle: 3 * quarterCircle, endAngle: quarterCircle, clockwise: false)

            // Bottom left corner
            let bottomLeft = topLeft.translated(by: 0, y: bounds.height)
            let bottomLeftCircleCentre = bottomLeft.translated(by: 5, y: -5)
            newPath.addArc(center: bottomLeftCircleCentre, radius: TicketView.cornerRadius, startAngle: quarterCircle * 2, endAngle: quarterCircle, clockwise: true)

            // Bottom right corner
            let bottomRight = bottomLeft.translated(by: bounds.width, y: 0)
            let bottomRightCircleCentre = bottomRight.translated(by: -5, y: -5)
            newPath.addArc(center: bottomRightCircleCentre, radius: TicketView.cornerRadius, startAngle: quarterCircle, endAngle: 0, clockwise: true)

            // Mid left cutout
            let midRight = bottomRight.translated(by: 0, y: cutoutY - bounds.height)
            newPath.addArc(center: midRight, radius: TicketView.cutoutRadius, startAngle: quarterCircle, endAngle: 3 * quarterCircle, clockwise: false)

            // Top right corner
            let topRight = bottomRight.translated(by: 0, y: -bounds.height)
            let topRightCircleCentre = topRight.translated(by: -5, y: 5)
            newPath.addArc(center: topRightCircleCentre, radius: TicketView.cornerRadius, startAngle: 0, endAngle: quarterCircle * 3, clockwise: true)

            // Back to origin in the top left
            newPath.closeSubpath()

            shapeMask.path = newPath
            layer.shadowPath = newPath

            maskAdjustedForPreviousBounds = bounds
        }

        super.draw(rect)
    }
}
