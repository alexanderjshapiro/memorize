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
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Text(card.content).font(Font.system(size: fontSize(for: geometry.size)))
                }
                .cardify(isFaceUp: card.isFaceUp, color: color)
                .foregroundColor(color)
            }
        }
    }
    
    // MARK: Drawing Constants
    
    private let cardAspectRatio: CGFloat = 2/3
    private let fontScalingFactor: CGFloat = 0.7
    private func fontSize(for size: CGSize) -> CGFloat { min(size.width, size.height) * fontScalingFactor }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards[0])
        return EmojiMemoryGameView(emojiMemoryGame: game)
    }
}
