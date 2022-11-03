//
//  CardAnimator.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/2.
//

import SwiftUI

/// A `ViewModifier` that animates a `CardView` to flip over.
struct CardAnimator: ViewModifier, Animatable{
    var isShown: Bool
    var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, isShown: Bool) {
        self.isShown = isShown
        self.rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                let cardback = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                cardback.fill().foregroundColor(rotation < 90 ? DrawingConstants.foreColor : DrawingConstants.backColor)
                cardback.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content.opacity(rotation < 90 ? 1 : 0)
            }
            .opacity(isShown ? 1 : 0)
            .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
            .animation(.easeInOut(duration: DrawingConstants.animationDuration), value: isShown)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let backColor: Color = .red
        static let foreColor: Color = .white
        static let lineWidth: CGFloat = 3
        static let animationDuration: Double  = 1
    }
}

extension View {
    func cardAnimation(isFaceUp: Bool, isShown: Bool) -> some View {
        self.modifier(CardAnimator(isFaceUp: isFaceUp, isShown: isShown))
    }
}

