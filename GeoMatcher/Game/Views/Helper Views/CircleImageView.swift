//
//  CircleImageView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/3.
//

import SwiftUI

struct CircleImageView: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 400, height: 240)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

