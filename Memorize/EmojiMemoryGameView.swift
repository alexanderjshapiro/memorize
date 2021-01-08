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
                    .onTapGesture {
                        withAnimation(Animation.linear(duration: 0.75)) { emojiMemoryGame.choose(card) }
                    }
                    .padding()
            }
            Divider()
            Button("New Game") {
                withAnimation(Animation.easeInOut) { emojiMemoryGame.newGame() }
            }.padding()
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(Animation.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(
                                startAngle: Angle.degrees(0-90),
                                endAngle: Angle.degrees(-animatedBonusRemaining*360-90)
                            )
                            .onAppear { startBonusTimeAnimation() }
                        } else {
                            Pie(
                                startAngle: Angle.degrees(0-90),
                                endAngle: Angle.degrees(-card.bonusRemaining*360-90)
                            )
                            
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    .transition(AnyTransition.identity)
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) : Animation.default)
                }
                .cardify(isFaceUp: card.isFaceUp, color: color)
                .foregroundColor(color)
                .transition(AnyTransition.scale)
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
