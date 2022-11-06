//
//  Settings.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/6.
//

import Foundation

struct Settings {
    var difficulty: Int
    var elementType1: ElementType
    var elementType2: ElementType
    var startingPairs: Int
    
    static var `default` = Settings(difficulty: 3, elementType1: .country, elementType2: .flag, startingPairs: 6)
}
