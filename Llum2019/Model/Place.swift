//
//  Place.swift
//  Llum2019
//
//  Created by Andrés Pizá Bückmann on 14/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import Foundation
import CoreLocation

struct Place: Decodable {
    let id: String
    let title: String
    let subtitle: String
    private let _coordinates: String
    let section: Section
    let image: String?
    let address: String

    var coordinates: CLLocationCoordinate2D {
        let commaSeparatedCoordinates = _coordinates.contains("||") ? _coordinates.components(separatedBy: "||").first! : _coordinates
        let stringCoordinates = commaSeparatedCoordinates.components(separatedBy: ", ")
        return CLLocationCoordinate2D(latitude: Double(stringCoordinates[0]) ?? 0,
                                      longitude: Double(stringCoordinates[1]) ?? 0)
    }

    enum CodingKeys: String, CodingKey {
        case place = "lloc"
        case id = "id"
        case title = "title"
        case subtitle = "subtitol"
        case coordinates = "cords"
        case section = "seccio"
        case image = "src"
        case imageContainer = "img"
        case address = "direccio"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let place = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .place)
        let imageContainer = try? place.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageContainer )

        id = try place.decode(String.self, forKey: .id)
        title = try place.decode(String.self, forKey: .title)
        subtitle = try place.decode(String.self, forKey: .subtitle)
        _coordinates = try place.decode(String.self, forKey: .coordinates)
        section = try place.decode(Section.self, forKey: .section)
        image = try imageContainer?.decode(String.self, forKey: .image)
        address = try place.decode(String.self, forKey: .address)
    }
}
