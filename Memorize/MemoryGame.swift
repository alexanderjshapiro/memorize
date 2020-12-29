//
//  MemoryGame.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/25/20.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.index(matching: card) {
            cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
        }
    }
    
    init(numPairs: Int, createCard: (Int) -> CardContent) {
        cards = Array<Card>()
        let random = Int.random(in: 2...5)
        for pairIndex in 0..<random {
            let content = createCard(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
