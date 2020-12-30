//
//  MemoryGame.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/25/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var theme: String
    var score: Int = 0
    var cards: Array<Card>
    
    var indexOfFaceUp: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.index(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUp {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].wasSeen {
                        score -= 1
                    }
                    if cards[potentialMatchIndex].wasSeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].wasSeen = true
            } else {
                indexOfFaceUp = chosenIndex
            }
        }
    }
    
    init(theme: String, numPairs: Int, createCard: (Int) -> CardContent) {
        self.theme = theme
        cards = Array<Card>()
        for pairIndex in 0..<numPairs {
            let content = createCard(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var wasSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
