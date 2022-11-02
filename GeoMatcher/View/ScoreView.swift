//
//  ScoreView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/2.
//

import SwiftUI

/// A `View` that shows the score and score increment.
struct ScoreView: View {
    @EnvironmentObject var game: GeoMatcherViewModel
    
    var body: some View {
        HStack {
            Text("Score: \(game.score, specifier: "%.2f")")
            if game.lastScore > 0 {
                Text(" +\(game.lastScore, specifier: "%.2f")  \(bonusTextOf(game.lastScore))")
                    .transition(AnyTransition.asymmetric(insertion: .slide, removal: .opacity))
                    .foregroundColor(colorOf(game.lastScore))
            }
        }
    }
    
    /// Returns a `Color` based on the `score` the user received.
    func colorOf(_ score: Double) -> Color {
        switch score {
            case 18...:
                return DrawingConstants.highBonusColor
            case 15...:
                return DrawingConstants.mediumBonusColor
            case 10...:
                return DrawingConstants.lowBonusColor
            case 0...:
                return DrawingConstants.noBonusColor
            default:
                assertionFailure("Negative score is not intended behaviour")
                return DrawingConstants.noBonusColor
        }
    }
    
    /// Returns a `String` based on the `score` the user received.
    func bonusTextOf(_ score: Double) -> String {
        switch score {
            case 18...:
                return "Perfect!"
            case 15...:
                return "Excellent!"
            case 10...:
                return "Nice!"
            case 0...:
                return ""
            default:
                assertionFailure("Negative score is not intended behaviour")
                return ""
        }
    }
    
    struct DrawingConstants {
        static var highBonusColor: Color = .red
        static var mediumBonusColor: Color = .green
        static var lowBonusColor: Color = .blue
        static var noBonusColor: Color = .black
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
