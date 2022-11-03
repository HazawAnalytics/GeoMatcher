//
//  SVGImageView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/3.
//

import SwiftUI
import SVGKit

struct SVGImageView: UIViewRepresentable {
    @Binding var url:URL
    @Binding var size:CGSize
    
    func makeUIView(context: Context) -> SVGKFastImageView {
        let svgImage = SVGKImage(contentsOf: url)
        return SVGKFastImageView(svgkImage: svgImage ?? SVGKImage())
    }
    
    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        uiView.image = SVGKImage(contentsOf: url)
        uiView.image.size = size
    }
}

struct SVGImageView_Previews: PreviewProvider {
    static var previews: some View {
        SVGImageView(url: .constant(URL(string:"https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AD.svg")!), size: .constant(CGSize(width:60,height:40)))
    }
}
