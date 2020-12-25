//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/25/20.
//

import SwiftUI

class EmojiMemoryGame {
    private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻","🎃","🕷"]
        return MemoryGame<String>(numPairs: emojis.count) { pairIndex in emojis[pairIndex] }
    }
    
    // MARK: Access to model
    
    var cards: Array<MemoryGame<String>.Card> {
        memoryGame.cards
    }
    
    // MARK: Intents
    func choose(card: MemoryGame<String>.Card) {
        memoryGame.choose(card: card)
    }
}
