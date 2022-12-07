//
//  ChessClockApp.swift
//  ChessClock
//
//  Created by Szymon Kocowski on 20/09/2022.
//

import SwiftUI

@main
struct ChessClockApp: App {
    @StateObject var model = ClockModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(model)
        }
    }
}
