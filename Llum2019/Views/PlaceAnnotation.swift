//
//  PlaceAnnotation.swift
//  Llum2019
//
//  Created by Andrés Pizá Bückmann on 14/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    let place: Place
    var coordinate: CLLocationCoordinate2D { return place.coordinates }

    init(place: Place) {
        self.place = place
    }

    var title: String? { return place.title }
}
