//
//  GeoMatcherView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/2.
//

import SwiftUI

/// The main `View` in the `GeoMatcher` game.
struct GeoMatcherView: View {
    @EnvironmentObject var game: GeoMatcherViewModel
    @Namespace private var namespace
    
    /// The number of pairs of cards to show at the start.
    private var startingPairs: Int = 3
    
    var body: some View {
        VStack {
            ScoreView()
            gameBody
            deckBody
            restart
        }
    }
    
    /// A `View` containing the grid of cards that has already been dealt.
    var gameBody: some View {
        AspectVGrid(items: game.cards.filter( {$0.isDealt} ), aspectRatio: DrawingConstants.aspectRatio) { card in
            CardView(card)
                .matchedGeometryEffect(id: card.id, in: namespace)
                .padding(DrawingConstants.cardPadding)
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
        .foregroundColor(DrawingConstants.cardBackColor)
        .onAppear {
            for index in 0..<startingPairs {
                withAnimation(Animation.linear(duration: DrawingConstants.dealDuration)
                    .delay(DrawingConstants.dealCardDelay * Double(index))) {
                        game.deal()
                    }
            }
            withAnimation(Animation.linear(duration: DrawingConstants.shuffleDuration)
                .delay(DrawingConstants.dealCardDelay * Double(startingPairs))){
                    game.shuffle()
                }
            
        }
    }
    
    /// A `View` containing the deck of cards that hasn't been dealt yet.
    /// When tapped on, deal out two new cards and shuffle.
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter( {!$0.isDealt} )) { card in
                CardView(card, forDeck: true)
                    .matchedGeometryEffect(id: card.id, in: namespace)
            }
        }
        .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
        .foregroundColor(DrawingConstants.cardBackColor)
        .onTapGesture {
            withAnimation(Animation.linear(duration: DrawingConstants.dealDuration)) {
                game.deal()
            }
            withAnimation(Animation.linear(duration: DrawingConstants.shuffleDuration)
                .delay(DrawingConstants.dealCardDelay)){
                game.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation(Animation.linear(duration: DrawingConstants.dealDuration)) {
                game.restart()
            }
            for index in 0..<startingPairs {
                withAnimation(Animation.linear(duration: DrawingConstants.dealDuration)
                    .delay(DrawingConstants.restartDelay + DrawingConstants.dealCardDelay * Double(index))) {
                        game.deal()
                    }
            }
            withAnimation(Animation.linear(duration: DrawingConstants.shuffleDuration)
                .delay(DrawingConstants.restartDelay + DrawingConstants.dealCardDelay * Double(startingPairs))) {
                game.shuffle()
            }
        }
    }
    
    private struct DrawingConstants {
        static let aspectRatio: CGFloat = 3/2
        static let cardPadding: CGFloat = 4
        static let deckHeight: CGFloat = 90
        static let deckWidth: CGFloat = deckHeight * DrawingConstants.aspectRatio
        static let cardBackColor: Color = Color.red
        static let dealDuration: CGFloat = 0.3
        static let shuffleDuration: CGFloat = 0.15
        static let restartDelay: Double = 1
        static let dealCardDelay: Double = 0.4
    }
}

struct GeoMatcherView_Previews: PreviewProvider {
    static var previews: some View {
        GeoMatcherView()
            .environmentObject(GeoMatcherViewModel())
    }
}
