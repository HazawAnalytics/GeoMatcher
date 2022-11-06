//
//  MapView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/3.
//

import SwiftUI
import MapKit

struct MapView: View {
    var locationCoordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                setRegion()
            }
    }
    
    private func setRegion() {
        region = MKCoordinateRegion(center: locationCoordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationCoordinate: GeoMatcherViewModel().cards[1].country.locationCoordinates)
    }
}
