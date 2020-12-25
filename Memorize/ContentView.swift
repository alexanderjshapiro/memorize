//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/24/20.
//

import SwiftUI

struct ContentView: View {
    var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(emojiMemoryGame.cards) { card in
                CardView(card: card).onTapGesture {
                    emojiMemoryGame.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    let CARD_RADIUS: CGFloat = 10.0
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: CARD_RADIUS).fill(Color.white)
                RoundedRectangle(cornerRadius: CARD_RADIUS).stroke(lineWidth: 3.0)
                Text(card.content)
            } else{
                RoundedRectangle(cornerRadius: CARD_RADIUS).fill(Color.orange)
            }
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiMemoryGame: EmojiMemoryGame())
    }
}
