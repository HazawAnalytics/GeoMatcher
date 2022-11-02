//
//  GeoMatcherViewModel.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/1.
//

import Foundation
import SwiftUI
import Combine

/// The view model of the GeoMatcher game.
final class GeoMatcherViewModel: ObservableObject {
    /// The game being played.
    @Published var game: GeoMatcher
    
    /// `Array` of cards used.
    var cards: [Card] {
        game.cards
    }
    
    /// The current score.
    var score: Double {
        game.score
    }
    
    /// The last score increment, 0 if never changed.
    var lastScore: Double {
        game.lastScore
    }
    
    /// Creates a `GeoMatcherViewModel` instance with cards of the `elementTypes`.
    init(elementTypes: (ElementType, ElementType)) {
        game = GeoMatcher(elementTypes: elementTypes)
    }
    
    /// Creates a `GeoMatcherViewModel` instance with default values. Only intended for testing purposes.
    init() {
        game = GeoMatcher(elementTypes: (.country, .flag))
    }
    
    // MARK: - Intent(s)
    /// Tells the game to choose the card given.
    func choose(_ card: Card) {
        objectWillChange.send()
        game.choose(card)
    }
    
    /// Tells the game to shuffle its cards.
    func shuffle() {
        game.shuffle()
    }
    
    /// Tells the game to deal out a pair of cards.
    func deal() {
        game.deal()
    }
    
    /// Tells the game to restart itself.
    func restart() {
        game.restart()
    }
    
}
