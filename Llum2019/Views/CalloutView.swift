//
//  CalloutView.swift
//  Llum2019
//
//  Created by Andrés Pizá Bückmann on 14/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import MapKit

class CalloutView: MKPinAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        canShowCallout = true
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        self.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        self.pinTintColor = getColor()
    }

    private func getColor() -> UIColor? {
        guard let place = (annotation as? PlaceAnnotation)?.place else { fatalError() }
        switch place.section {
        case .installation:
            return .red
        case .gastro:
            return .cyan
        case .info:
            return .yellow
        case .space:
            return .green
        case .parking:
            return .gray
        case .restaurant:
            return .blue
        }
    }
}
