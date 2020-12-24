//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Shapiro on 12/24/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(content: {
            let CARD_RADIUS: CGFloat = 10.0
            RoundedRectangle(cornerRadius: CARD_RADIUS).fill(Color.white)
            RoundedRectangle(cornerRadius: CARD_RADIUS).stroke(lineWidth: 3.0)
            Text("👻")
        })
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
