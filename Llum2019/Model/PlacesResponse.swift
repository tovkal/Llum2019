//
//  PlacesResponse.swift
//  Llum2019
//
//  Created by Andrés Pizá Bückmann on 14/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import Foundation

struct PlacesResponse: Decodable {
    let places: [Place]

    enum CodingKeys: String, CodingKey {
        case places = "llocs"
    }
}
