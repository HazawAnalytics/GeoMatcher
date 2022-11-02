//
//  GeoMatcher.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/1.
//

import Foundation

/// A `struct` of the model of the GeoMatcher game.
struct GeoMatcher {
    /// `Array` of cards used.
    private(set) var cards: [Card] = []
    /// The two `ElementType`s used.
    private var elementTypes: (ElementType, ElementType)
    /// The country data used.
    private(set) var countries: [Country] = GeoMatcher.loadData(GeoMatcher.dataFile)
    /// The index of the only face up card, if it exists, `nil` otherwise.
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            // Filters all the face up cards in the cards array
            let faceUpIndices = cards.indices.filter({ cards[$0].isFaceUp })
            // Returns the index if there's one card left after filtering, else returns nil
            return faceUpIndices.count == 1 ? faceUpIndices[0] : nil
        }
        set {
            // Sets card at the specified index to face up, and all others to face down
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    /// The current score.
    private(set) var score: Double = 0
    /// The last score increment, 0 if never changed.
    private(set) var lastScore: Double = 0
    
    /// Creates a `GeoMatcher` instance with cards of the `elementTypes`.
    init(elementTypes: (ElementType, ElementType)) {
        self.elementTypes = elementTypes
        
        // Randomly generate a number of indices to use on the country array
        let randomedIndices = countries.indices.shuffled()
        // Populate the cards array with the selected countries and the element types used in game
        for index in randomedIndices {
            cards.append(Card(country: countries[index], elementType: elementTypes.0, id: index*2))
            cards.append(Card(country: countries[index], elementType: elementTypes.1, id: index*2+1))
        }
        
        shuffle()
    }
    
    /// Chooses a card.
    /// If the chosen card is not already matched and is face down, checks if there is exactly one face up card.
    /// If there is, checks if the chosen card matches with that card.
    /// Otherwise, the chosen card becomes the only face up card.
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !card.isMatched,
           !card.isFaceUp
        {
            lastScore = 0
            if let faceUpIndex = indexOfOnlyFaceUpCard {
                cards[chosenIndex].isFaceUp = true
                if cards[chosenIndex].checkMatching(with: cards[faceUpIndex]) {
                    cards[chosenIndex].isMatched = true
                    cards[faceUpIndex].isMatched = true
                    lastScore = 10 + 10 * min(cards[chosenIndex].bonusTimePercentage, cards[faceUpIndex].bonusTimePercentage)
                    score += lastScore
                }
            } else {
                indexOfOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    /// Shuffles the cards array.
    mutating func shuffle() {
        cards.shuffle()
    }
    
    /// Deals out two cards with matching countries.
    mutating func deal() {
        // Find the first undealt card in the array (if any) and the card in the array that matches with it (if any)
        if let firstUndealtCardIndex = cards.firstIndex(where: { !$0.isDealt }),
           let matchingCardIndex = cards.firstIndex(where: { cards[firstUndealtCardIndex].id != $0.id && cards[firstUndealtCardIndex].checkMatching(with: $0) }),
           cards.filter( {$0.isDealt} ).count < GeoMatcher.maximumCards
        {
            cards[firstUndealtCardIndex].isDealt = true
            cards[matchingCardIndex].isDealt = true
        }
    }
    
    /// Restarts the game with a new set of countries.
    mutating func restart() {
        score = 0
        lastScore = 0
        cards = []

        let randomedIndices = countries.indices.shuffled()
        for index in randomedIndices {
            cards.append(Card(country: countries[index], elementType: elementTypes.0, id: index*2))
            cards.append(Card(country: countries[index], elementType: elementTypes.1, id: index*2+1))
        }
        
        shuffle()
    }

    /// Returns the decoded `JSON` data from the file provided.
    static func loadData<T:Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Cannot read file with \(filename).")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Reading data from \(filename) failed.")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Decoding data from \(filename) failed as \(T.self):\n\(error).")
        }
    }
    
    /// The name of the file with the country data used.
    static let dataFile = "countryData.json"
    
    /// The maximum amount of cards the game supports.
    static let maximumCards = 36
}
