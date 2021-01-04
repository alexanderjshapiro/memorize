//
//  Cardify.swift
//  Memorize
//
//  Created by Alexander Shapiro on 1/3/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(cardFaceColor)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(color)
            }
        }
    }
    
    var color: Color
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    private let cardFaceColor = Color.white
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
