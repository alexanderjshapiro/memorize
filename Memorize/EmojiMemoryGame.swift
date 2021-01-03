//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/25/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let themes = [
            "animals": (emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🐔","🐧","🐦","🐺","🐗","🐴","🐝"], color: nil, forcedNumPairs: nil),
            "nature": (emojis: ["🌵","🌲","🌳","🌴","🌱","🌿","☘️","🍂","🍁","🍄","🌾","🌷","🌹","🌺","🌸","🌼","🌻"], color: Color.green, forcedNumPairs: nil),
            "fruit": (emojis: ["🍎","🍊","🍌","🍉","🍇","🍓","🫐","🍒","🍑","🥭","🍍","🥥","🥝"], color: nil, forcedNumPairs: nil),
            "sports": (emojis: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🏓","🏸","🏒","🥍","🏏","🥊"], color: nil, forcedNumPairs: nil),
            "halloween": (emojis: ["👻","🎃","🕷","🕸","💀","🧟","👹","👺","🤡","👽","🧛‍♂️","🩸"], color: Color.orange, forcedNumPairs: nil),
            "christmas": (emojis: ["🦌","🎄","❄️","⛄️","🎁","🧤","🧣"], color: Color.green, forcedNumPairs: 6)
        ]
        
        let emojiGameTheme = themes.randomElement()!.key
        let selectedEmojis = themes[emojiGameTheme]!.emojis.shuffled()
        let emojiGameColor = themes[emojiGameTheme]!.color ?? Color.gray
        let emojiGameNumPairs = themes[emojiGameTheme]!.forcedNumPairs ?? ( (selectedEmojis.count < 5) ? selectedEmojis.count : Int.random(in: 2...5) )
        return MemoryGame<String>(theme: emojiGameTheme, color: emojiGameColor, numPairs: emojiGameNumPairs) { pairIndex in selectedEmojis[pairIndex] }
    }
    
    // MARK: Access to model
    
    var theme: String { memoryGame.theme }
    var color: Color { memoryGame.color }
    var score: Int { memoryGame.score }
    var cards: Array<MemoryGame<String>.Card> { memoryGame.cards }
    
    // MARK: Intents
    
    func choose(_ card: MemoryGame<String>.Card) { memoryGame.choose(card) }
    
    func newGame() { memoryGame = EmojiMemoryGame.createMemoryGame() }
}
