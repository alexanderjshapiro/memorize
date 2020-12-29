//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/25/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    var fontSize = Font.largeTitle
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻","🎃","🕷","🕸","💀","🧟","👹","👺","🤡","👽","🧛‍♂️","🩸"]
        let shuffledEmojis = emojis.shuffled()
        return MemoryGame<String>(numPairs: emojis.count) { pairIndex in shuffledEmojis[pairIndex] }
    }
    
    // MARK: Access to model
    
    var cards: Array<MemoryGame<String>.Card> { memoryGame.cards }
    
    // MARK: Intents
    
    func choose(_ card: MemoryGame<String>.Card) { memoryGame.choose(card) }
}
