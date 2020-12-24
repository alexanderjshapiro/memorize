//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/24/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                CardView(isFaceUp: false)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    let CARD_RADIUS: CGFloat = 10.0
    var isFaceUp: Bool
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: CARD_RADIUS).fill(Color.orange)
            } else{
                RoundedRectangle(cornerRadius: CARD_RADIUS).fill(Color.white)
                RoundedRectangle(cornerRadius: CARD_RADIUS).stroke(lineWidth: 3.0)
                Text("👻")
            }
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
