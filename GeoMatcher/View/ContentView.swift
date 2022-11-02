//
//  ContentView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/10/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeoMatcherView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GeoMatcherViewModel())
    }
}
