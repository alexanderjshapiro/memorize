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
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return -1 // TODO: bogus!
    }
    
    init(numPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        let random = Int.random(in: 2...5)
        for pairIndex in 0..<random {
            let content = cardContentFactory(pairIndex)
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
