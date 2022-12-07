//
//  RectangleButton.swift
//  ChessClock
//
//  Created by Szymon Kocowski on 21/09/2022.
//

import SwiftUI

struct RectangleButton: View {
    
    @Binding var value: Int
    
    enum RectangleStyle {
        case start
        case pause
        
        var bgColour: Color {
            switch self {
            case .start:
                return Color.blue
            case .pause:
                return Color.white
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .start:
                return Color.white
            case .pause:
                return Color.black
            }
        }
    }
    
    var style: RectangleStyle
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(style.bgColour)
                .frame(width: .infinity, height: .infinity)
            VStack {
                Text(TimeFormat.timeAsText(value))
                    .foregroundColor(style.foregroundColor)
                    .font(.system(size: 70, weight: .bold, design: .default))
                
            }
        }
    }
}

struct RectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RectangleButton(value: Binding.constant(100), style: .pause)
    }
}
