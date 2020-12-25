//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/24/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(emojiMemoryGame: game)
        }
    }
}
