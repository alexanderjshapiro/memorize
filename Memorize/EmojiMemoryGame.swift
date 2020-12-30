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
            "animals": (emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🐔","🐧","🐦","🐺","🐗","🐴","🐝"], forcedNumPairs: nil),
            "nature": (emojis: ["🌵","🌲","🌳","🌴","🌱","🌿","☘️","🍂","🍁","🍄","🌾","🌷","🌹","🌺","🌸","🌼","🌻"], forcedNumPairs: nil),
            "fruit": (emojis: ["🍎","🍊","🍌","🍉","🍇","🍓","🫐","🍒","🍑","🥭","🍍","🥥","🥝"], forcedNumPairs: nil),
            "sports": (emojis: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🏓","🏸","🏒","🥍","🏏","🥊"], forcedNumPairs: nil),
            "halloween": (emojis: ["👻","🎃","🕷","🕸","💀","🧟","👹","👺","🤡","👽","🧛‍♂️","🩸"], forcedNumPairs: nil),
            "christmas": (emojis: ["🦌","🎄","❄️","⛄️","🎁","🧤","🧣"], forcedNumPairs: 6)
        ]
        
        let emojiGameTheme = themes.randomElement()!.key
        let selectedEmojis = themes[emojiGameTheme]!.emojis.shuffled()
        let numPairs = themes[emojiGameTheme]!.forcedNumPairs ?? ( (selectedEmojis.count < 5) ? selectedEmojis.count : Int.random(in: 2...5) )
        return MemoryGame<String>(theme: emojiGameTheme, numPairs: numPairs) { pairIndex in selectedEmojis[pairIndex] }
    }
    
    // MARK: Access to model
    
    var theme: String { memoryGame.theme }
    var score: Int { memoryGame.score }
    var cards: Array<MemoryGame<String>.Card> { memoryGame.cards }
    
    // MARK: Intents
    
    func choose(_ card: MemoryGame<String>.Card) { memoryGame.choose(card) }
    
    func newGame() { memoryGame = EmojiMemoryGame.createMemoryGame() }
}
