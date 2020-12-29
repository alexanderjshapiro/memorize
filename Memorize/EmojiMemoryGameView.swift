//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/24/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    var body: some View {
        Grid(emojiMemoryGame.cards) { card in
            CardView(card)
            .onTapGesture { emojiMemoryGame.choose(card) }
            .padding()
        }
        .padding()
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(cardFaceColor)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(cardColor)
                }
            }
            .foregroundColor(Color.orange)
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    
    // MARK: Drawing Constants
    
    let cardAspectRatio: CGFloat = 2/3
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScalingFactor: CGFloat = 0.75
    func fontSize(for size: CGSize) -> CGFloat { min(size.width, size.height) * fontScalingFactor }
    let cardColor = Color.orange
    let cardFaceColor = Color.white
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(emojiMemoryGame: game)
    }
}
