//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/25/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame = EmojiMemoryGame.createMemoryGame()
    
    static let themes = [
        "animals": (
            emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🐔","🐧","🐦","🐺","🐗","🐴","🐝"],
            color: nil,
            forcedNumPairs: nil
        ),
        "nature": (
            emojis: ["🌵","🌲","🌳","🌴","🌱","🌿","☘️","🍂","🍁","🍄","🌾","🌷","🌹","🌺","🌸","🌼","🌻"],
            color: Color.green,
            forcedNumPairs: nil
        ),
        "fruit": (
            emojis: ["🍎","🍊","🍌","🍉","🍇","🍓","🫐","🍒","🍑","🥭","🍍","🥥","🥝"],
            color: nil,
            forcedNumPairs: nil
        ),
        "sports": (
            emojis: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🏓","🏸","🏒","🥍","🏏","🥊"],
            color: nil,
            forcedNumPairs: nil
        ),
        "halloween": (
            emojis: ["👻","🎃","🕷","🕸","💀","🧟","👹","👺","🤡","👽","🧛‍♂️","🩸"],
            color: Color.orange,
            forcedNumPairs: nil
        ),
        "christmas": (
            emojis: ["🦌","🎄","❄️","⛄️","🎁","🧤","🧣"],
            color: Color.green,
            forcedNumPairs: 6
        )
    ]
    
    private static func createMemoryGame() -> (game: MemoryGame<String>, theme: String, color: Color) {
        let emojiGameTheme = themes.randomElement()!.key
        let selectedEmojis = themes[emojiGameTheme]!.emojis.shuffled()
        let emojiGameColor = themes[emojiGameTheme]!.color ?? Color.gray
        let emojiGameNumPairs = themes[emojiGameTheme]!.forcedNumPairs ?? ( (selectedEmojis.count < 5) ? selectedEmojis.count : Int.random(in: 2...5) )
        return (game: MemoryGame<String>(numPairs: emojiGameNumPairs) { pairIndex in selectedEmojis[pairIndex] }, theme: emojiGameTheme, color: emojiGameColor)
    }
    
    // MARK: Access to model
    
    var theme: String { memoryGame.theme }
    var color: Color { memoryGame.color }
    var score: Int { memoryGame.game.score }
    var cards: Array<MemoryGame<String>.Card> { memoryGame.game.cards }
    
    // MARK: Intents
    
    func choose(_ card: MemoryGame<String>.Card) { memoryGame.game.choose(card) }
    
    func newGame() { memoryGame = EmojiMemoryGame.createMemoryGame() }
}
