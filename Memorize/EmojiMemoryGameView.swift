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
        VStack {
            HStack {
                Text(emojiMemoryGame.theme.capitalized)
                    .font(Font.largeTitle)
                    .bold()
                Spacer()
                Text("\(emojiMemoryGame.score)").font(Font.system(Font.TextStyle.title, design: Font.Design.monospaced))
            }.padding()
            Divider()
            Grid(emojiMemoryGame.cards) { card in
                CardView(card, color: emojiMemoryGame.color)
                    .onTapGesture { emojiMemoryGame.choose(card) }
                    .padding()
            }
            Divider()
            Button("New Game") { emojiMemoryGame.newGame() }.padding()
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var color: Color
    
    init(_ card: MemoryGame<String>.Card, color: Color) {
        self.card = card
        self.color = color
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    RoundedRectangle(cornerRadius: cornerRadius).fill(cardFaceColor)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                        RoundedRectangle(cornerRadius: cornerRadius).fill(color)
                    }
                }
            }
            .foregroundColor(color)
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    
    // MARK: Drawing Constants
    
    private let cardAspectRatio: CGFloat = 2/3
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    private let fontScalingFactor: CGFloat = 0.75
    private func fontSize(for size: CGSize) -> CGFloat { min(size.width, size.height) * fontScalingFactor }
    private let cardFaceColor = Color.white
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(emojiMemoryGame: game)
    }
}
