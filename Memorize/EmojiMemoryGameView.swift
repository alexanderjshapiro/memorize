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
        HStack {
            ForEach(emojiMemoryGame.cards) { card in
                CardView(card: card).onTapGesture {
                    emojiMemoryGame.choose(card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else{
                    RoundedRectangle(cornerRadius: cornerRadius).fill(cardColor)
                }
            }
            .aspectRatio(cardAspectRatio, contentMode: .fit)
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    
    // MARK: Drawing Constants
    
    let cardAspectRatio: CGFloat = 2/3
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScalingFactor: CGFloat = 0.75
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScalingFactor
    }
    let cardColor: Color = Color.orange
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
