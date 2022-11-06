//
//  Profile.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/6.
//

import Foundation

struct Profile {
    var username: String
    var highscore: Double = 0
    
    static var `default` = Profile(username: "Tsugu")
}
