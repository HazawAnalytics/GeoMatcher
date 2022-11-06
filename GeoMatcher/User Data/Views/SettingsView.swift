//
//  SettingsView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/6.
//

import SwiftUI

/// The `View` that handles user game settings.
struct SettingsView: View {
    /// The `Settings` that are being shown and changed.
    @Binding var settings: Settings
    
    var body: some View {
        List {
            // Segmented picker for game difficulty
            VStack(alignment: .leading, spacing: 20) {
                Text("Game Difficulty").bold()
                Picker("Game Difficulty", selection: $settings.difficulty) {
                    ForEach(1..<6) {difficulty in
                        Text("\(difficulty)").tag(difficulty)
                    }
                }
                .pickerStyle(.segmented)
            }
            // Segmented pickers for the two element types
            VStack(alignment: .leading, spacing: 20) {
                Text("Card Types").bold()
                Picker("Card Type 1", selection: $settings.elementType1) {
                    ForEach(ElementType.allCases) { elementType in
                        Text(elementType.rawValue).tag(elementType)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Card Type 2", selection: $settings.elementType2) {
                    ForEach(ElementType.allCases) { elementType in
                        Text(elementType.rawValue).tag(elementType)
                    }
                }
                .pickerStyle(.segmented)
            }
            // Wheel picker for the number of starting pairs to display
            VStack(alignment:.leading, spacing: 20) {
                Text("Number of Pairs to Start").bold()
                Picker("Number of Pairs to start", selection: $settings.startingPairs) {
                    ForEach(1..<19) {startingPairs in
                        Text("\(startingPairs)").tag(startingPairs)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: .constant(Settings.default))
    }
}
