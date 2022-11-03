//
//  CountryDetailView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/3.
//

import SwiftUI

struct CountryDetailView: View {
    var country: Country
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.red)
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: GeoMatcherViewModel().cards[0].country)
    }
}
