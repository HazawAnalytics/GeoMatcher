//
//  CardView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/2.
//

import SwiftUI

/// A `View` that shows a single `Card`.
struct CardView: View {
    private let card: Card
    private let forDeck: Bool
    @State private var animatedBonusPercentage: Double = 0
    
    /// Creates an instance with the `card` and whether or not it's used `forDeck`.
    init(_ card: Card, forDeck: Bool = false) {
        self.card = card
        self.forDeck = forDeck
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.strokeBorder(lineWidth: DrawingConstants.strokeWidth)
                shape.fill().foregroundColor(DrawingConstants.cardColor)
                Text(card.content)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .padding()
                // If the card is using bonus time, displays a `RoundedRectangle` that represents time countdown.
                // Otherwise, displays a `RoundedRectangle` that represents the bonus time left.
                if card.isConsumingBonusTime {
                    let workingTimer = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    workingTimer.size(width: geometry.size.width*animatedBonusPercentage, height: geometry.size.height)
                         .fill(DrawingConstants.timerColor)
                         .opacity(DrawingConstants.timerOpacity)
                         .onAppear {
                            animatedBonusPercentage = card.bonusTimePercentage
                            withAnimation(Animation.linear(duration: card.bonusTimeRemaining)){
                                animatedBonusPercentage = 0
                            }
                        }
                    workingTimer.strokeBorder(lineWidth: DrawingConstants.strokeWidth)
                } else {
                    let stoppedTimer = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    stoppedTimer.size(width: geometry.size.width*card.bonusTimePercentage, height: geometry.size.height)
                        .fill(DrawingConstants.timerColor)
                        .opacity(DrawingConstants.timerOpacity)
                    stoppedTimer.strokeBorder(lineWidth: DrawingConstants.strokeWidth)
                }
            }
            .cardAnimation(isFaceUp: card.isFaceUp || card.isFinal,
                           isShown: (card.isDealt && !card.isMatched) || forDeck || card.isFinal)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let timerOpacity: CGFloat = 0.5
        static let piePadding: CGFloat = 5
        static let strokeWidth: CGFloat = 3
        static let cardColor: Color = Color.white
        static let timerColor: Color = Color.cyan
        static let pieStartAngle: Angle = Angle(degrees: 270)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(GeoMatcherViewModel().cards[0], forDeck: false)
    }
}
