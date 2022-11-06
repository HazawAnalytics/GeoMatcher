//
//  GeoMatcherApp.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/10/28.
//

import SwiftUI

@main
struct GeoMatcherApp: App {
    @StateObject private var game = GeoMatcherViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
