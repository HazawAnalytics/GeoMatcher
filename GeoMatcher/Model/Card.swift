//
//  Card.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/2.
//

import Foundation

/// A `struct` that represents a single card in the `GeoMatcher` game.
struct Card: Identifiable {
    /// A `Bool` that is true when the card is face up.
    var isFaceUp: Bool = false {
        didSet {
            if isFaceUp {
                startBonusTime()
            } else {
                stopBonusTime()
            }
        }
    }
    /// A `Bool` that is true when the card is matched with another card.
    var isMatched: Bool = false
    /// A `Bool` that is true when the card is dealt (i.e. not in the deck)
    var isDealt: Bool = false
    /// The `Country` used in the card.
    var country: Country
    /// The `ElementType` of the country to show on the card.
    var elementType: ElementType
    /// The identifier of the card.
    var id: Int
    
    /// The content displayed on the card.
    var content: String {
        switch elementType {
            case .flag:
                return country.emoji
            case .country:
                return country.name
            case .capital:
                return country.capital
        }
    }
    
    /// The bonus time limit for this card.
    var bonusTimeLimit: TimeInterval = 6
    /// The last `Date` that this card is face up.
    var lastFaceUpDate: Date?
    /// The current amount of time that this card has been face up for.
    var pastFaceUpTime: TimeInterval = 0
    
    /// The total amount of time that this card has been face up for.
    private var faceUpTime: TimeInterval {
        if let lastFaceUpDate = self.lastFaceUpDate {
            return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
        } else {
            return pastFaceUpTime
        }
    }
    
    /// The remaining amount of bonus time.
    var bonusTimeRemaining: TimeInterval {
        max(0, bonusTimeLimit - faceUpTime)
    }
    
    /// The percentage of bonus time left.
    var bonusTimePercentage: Double {
        (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    
    /// Whether or not the user has earned bonus from this card.
    var hasEarnedBonus: Bool {
        bonusTimePercentage > 0 && isMatched
    }
    
    /// Whether or not the user is currently using bonus time of this card.
    var isConsumingBonusTime: Bool {
        isFaceUp && !isMatched && bonusTimePercentage > 0
    }
    
    /// Returns `true` if the card passed in matches with this card, `false` otherwise.
    func checkMatching(with card: Card) -> Bool {
        return country==card.country
    }
    
    /// Starts using bonus time of this card.
    mutating func startBonusTime() {
        if isConsumingBonusTime, lastFaceUpDate == nil {
            lastFaceUpDate = Date()
        }
    }
    
    /// Stops using bonus time of this card.
    mutating func stopBonusTime() {
        pastFaceUpTime = faceUpTime
        lastFaceUpDate = nil
    }
}
