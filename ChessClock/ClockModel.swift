//
//  ClockModel.swift
//  ChessClock
//
//  Created by Szymon Kocowski on 21/09/2022.
//

import Foundation

class ClockModel: ObservableObject {
    
    @Published var counterPlayer1 = 300
    @Published var counterPlayer2 = 300
    @Published var increment1 = 0
    @Published var increment2 = 0

}

struct Player {
    var remainingTime: Int = 500
    var increment: Int = 0
    var moves: Int = 0
    var showingAlert = false
    
    mutating func onEnd() {
        
        if moves > 0 {
            remainingTime += increment
        }
        moves += 1
    }
    
    mutating func decreaseTime(_ amount: Int) {
        if remainingTime > 0 {
            remainingTime -= amount
        }
        else {
            showingAlert = true
        }
    }
}


struct TimeFormat {
    static func secondsTransformation(_ seconds: Int) -> (Int, Int) {
         ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func timeAsText(_ seconds: Int) -> String {
        let (m, s) = secondsTransformation(seconds)
        
        return String(format: "%02d:%02d", m, s)
    }
    
    static func timeForSettings(_ seconds: Int) -> String {
        let (m, s) = secondsTransformation(seconds)
        if s != 0 {
            return String(format: "%01d min, %01d sec", m, s)
        } else {
            return String(format: "%01d min", m)
        }
        
    }
    
    static func settingsIntoSeconds(minutes: Int, seconds: Int) -> Int {
        minutes * 60 + seconds
    }
}




