//
//  ContentView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/10/28.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSettings = false
    @State private var showingProfile = false
    @EnvironmentObject var game: GeoMatcherViewModel
    
    var body: some View {
        NavigationView {
            GeoMatcherView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showingProfile.toggle()
                        } label: {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingSettings.toggle()
                        } label: {
                            Label("Settings", systemImage: "slider.horizontal.3")
                        }
                    }
                }
                .sheet(isPresented: $showingSettings) {
                    SettingsView(settings: $game.settings)
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileView()
                        .environmentObject(game)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GeoMatcherViewModel())
    }
}
