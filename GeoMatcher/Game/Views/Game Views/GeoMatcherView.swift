//
//  GeoMatcherView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/2.
//

import SwiftUI
import SVGKit

/// The main `View` in the `GeoMatcher` game.
struct GeoMatcherView: View {
    @EnvironmentObject var game: GeoMatcherViewModel
    @Namespace private var namespace
    @State var hasEnded = false
    
    var body: some View {
        ZStack {
            gameEndBody
                .opacity(hasEnded ? 1 : 0)
            VStack {
                ZStack{
                    ScoreView()
                    restartButton
                }
                gameBody
                deckBody
            }
            .opacity(hasEnded ? 0 : 1)
        }
    }
    
    /// A `View` containing the grid of cards that has already been dealt.
    var gameBody: some View {
        NavigationView {
            ZStack {
                AspectVGrid(items: game.cards.filter( {$0.isDealt} ), aspectRatio: DrawingConstants.aspectRatio) { card in
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: namespace)
                        .padding(DrawingConstants.cardPadding)
                        .onTapGesture {
                            withAnimation {
                                game.choose(card)
                            }
                            withAnimation(Animation.easeInOut(duration: DrawingConstants.gameEndDuration)
                                .delay(DrawingConstants.gameStartDelay)) {
                                    hasEnded = game.hasEnded
                                }
                        }
                }
                .foregroundColor(DrawingConstants.cardBackColor)
                .onAppear {
                    for index in 0..<game.settings.startingPairs {
                        withAnimation(Animation.linear(duration: DrawingConstants.dealDuration)
                            .delay(DrawingConstants.dealCardDelay * Double(index))) {
                                game.deal()
                            }
                    }
                    withAnimation(Animation.linear(duration: DrawingConstants.shuffleDuration)
                        .delay(DrawingConstants.dealCardDelay * Double(game.settings.startingPairs))){
                            game.shuffle()
                        }
                    
                }
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
    
    var gameEndBody: some View {
        VStack {
            ZStack {
                VStack {
                    Text("Your final score is \(game.score, specifier: "%.2f")")
                    Text("Click on the cards to learn more.")
                }
                restartButton
            }
            NavigationView {
                AspectVGrid(items: game.cards.filter( {$0.isFinal} ), aspectRatio: DrawingConstants.aspectRatio) { card in
                    NavigationLink {
                        CountryDetailView(country: card.country)
                    } label: {
                        CardView(card)
                            .padding(DrawingConstants.cardPadding)
                    }
                }
            }
            Spacer()
        }
    }
    
    var restartButton: some View {
        Button {
            withAnimation(Animation.easeInOut(duration: DrawingConstants.gameEndDuration)) {
                hasEnded = false
            }
            withAnimation(Animation.linear(duration: DrawingConstants.dealDuration)
                .delay(DrawingConstants.gameStartDelay)) {
                game.restart()
            }
            for index in 0..<game.settings.startingPairs {
                withAnimation(Animation.linear(duration: DrawingConstants.dealDuration)
                    .delay(DrawingConstants.gameStartDelay + DrawingConstants.restartDelay + DrawingConstants.dealCardDelay * Double(index))) {
                        game.deal()
                    }
            }
            withAnimation(Animation.linear(duration: DrawingConstants.shuffleDuration)
                .delay(DrawingConstants.gameStartDelay + DrawingConstants.restartDelay + DrawingConstants.dealCardDelay * Double(game.settings.startingPairs))) {
                    game.shuffle()
                }
        } label: {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "goforward")
                }
                .padding(.trailing)
            }
        }
    }
    
    private struct DrawingConstants {
        static let aspectRatio: CGFloat = 3/2
        static let cardPadding: CGFloat = 4
        static let deckHeight: CGFloat = 90
        static let deckWidth: CGFloat = deckHeight * DrawingConstants.aspectRatio
        static let cardBackColor: Color = Color.red
        static let gameEndDuration: CGFloat = 1
        static let dealDuration: CGFloat = 0.3
        static let shuffleDuration: CGFloat = 0.15
        static let gameStartDelay: CGFloat = 0.5
        static let restartDelay: Double = 0.4
        static let dealCardDelay: Double = 0.4
    }
}

struct GeoMatcherView_Previews: PreviewProvider {
    static var previews: some View {
        GeoMatcherView()
            .environmentObject(GeoMatcherViewModel())
    }
}
