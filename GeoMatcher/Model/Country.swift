//
//  Country.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/1.
//

import Foundation
import SwiftUI
import CoreLocation

/// A `struct` to load and store a country's data.
struct Country: Hashable, Codable, Identifiable, Equatable {
    /// Name of the country.
    var name: String
    /// Identifier of the country.
    var id: String
    /// Emoji of the country's flag.
    var emoji: String
    /// Capital of the country.
    var capital: String
    /// Difficulty level of matching the country.
    var difficulty: Int
    /// `String` of the link to an image of the country's flag.
    var image: String
    
    private var coordinates: Coordinates
    var locationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double

    }
    
    /// Comparator of two countries. Returns true if they share the same id, false otherwise.
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
}
