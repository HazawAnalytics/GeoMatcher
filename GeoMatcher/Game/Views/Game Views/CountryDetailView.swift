//
//  CountryDetailView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/3.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    var country: Country
    
    var body: some View {
        ScrollView {
            MapView(locationCoordinate: country.locationCoordinates)
                .ignoresSafeArea(edges: .top)
                .frame(height:300)
            
            CircleImageView(image: Image("Argentina"))
                .offset(y: -120)
                .padding(.bottom, -120)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(country.name)
                        .font(.largeTitle)
                    Spacer()
                }
                HStack {
                    Text("Capital: \(country.capital)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Divider()
                Text("About \(country.name)")
                    .font(.title2)
                Text("Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam. Inceptos egestas maecenas imperdiet eget id donec nisl curae congue, massa tortor vivamus ridiculus integer porta ultrices venenatis aliquet, curabitur et posuere blandit magnis dictum auctor lacinia, eleifend dolor in ornare vulputate ipsum morbi felis. Faucibus cursus malesuada orci ultrices diam nisl taciti torquent, tempor eros suspendisse euismod condimentum dis velit mi tristique, a quis etiam dignissim dictum porttitor lobortis ad fermentum, sapien consectetur dui dolor purus elit pharetra. Interdum mattis sapien ac orci vestibulum vulputate laoreet proin hac, maecenas mollis ridiculus morbi praesent cubilia vitae ligula vel, sem semper volutpat curae mauris justo nisl luctus, non eros primis ultrices nascetur erat varius integer.")
            }
            .padding(.leading)
        }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: GeoMatcherViewModel().cards[0].country)
    }
}
