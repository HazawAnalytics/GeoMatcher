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
    @Published var settings: Settings
    @Published var profile: Profile
    
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
    
    /// Whether or not the game has ended.
    var hasEnded: Bool {
        game.hasEnded
    }
    
    /// Creates a `GeoMatcherViewModel` instance with default values. Only intended for testing purposes.
    init() {
        settings = Settings(difficulty: 3, elementType1: .country, elementType2: .flag, startingPairs: 3)
        profile = Profile.default
        game = GeoMatcher(difficulty: 3, elementTypes: (.country, .flag))
    }
    
    // MARK: - Intent(s)
    /// Tells the game to choose the card given.
    func choose(_ card: Card) {
        objectWillChange.send()
        profile.highscore = max(profile.highscore, game.score)
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
        game = GeoMatcher(difficulty: settings.difficulty, elementTypes: (settings.elementType1, settings.elementType2))
    }
    
}
