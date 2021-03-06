//
//  MemoryGame.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/25/20.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    var score: Int = 0
    private(set) var cards: Array<Card>
    
    private var indexOfFaceUp: Int? {
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
    
    init(numPairs: Int, createCard: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numPairs {
            let content = createCard(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var wasSeen: Bool = false
        var content: CardContent
        var id: Int
        
        // MARK: Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeLimit > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
