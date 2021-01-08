//
//  Cardify.swift
//  Memorize
//
//  Created by Alexander Shapiro on 1/3/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool { rotation < 90 }
    
    init(isFaceUp: Bool, color: Color) {
        rotation = isFaceUp ? 0 : 180
        self.color = color
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(cardFaceColor)
                content
            }.opacity(isFaceUp ? 1 : 0)
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(color)
            }.opacity(isFaceUp ? 0 : 1)
        }.rotation3DEffect( Angle.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0) )
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
