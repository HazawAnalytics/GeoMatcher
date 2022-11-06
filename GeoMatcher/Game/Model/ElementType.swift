//
//  ElementType.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/1.
//

import Foundation

/// Enum that represents the type of element to display on a card.
enum ElementType: String, CaseIterable, Identifiable {
    case country = "Country"
    case flag = "Flag"
    case capital = "Capital"
    
    var id: String { rawValue }
}
