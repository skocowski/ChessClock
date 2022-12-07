//
//  SettingsView.swift
//  ChessClock
//
//  Created by Szymon Kocowski on 21/09/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var model: ClockModel
    @Environment(\.dismiss) var dismiss

    @State private var player1Minutes = 0
    @State private var player1Seconds = 0
    @State private var player1Increment = 0
    @State private var player2Minutes = 0
    @State private var player2Seconds = 0
    @State private var player2Increment = 0
    
    @State private var player2Same = true
    
    var body: some View {

            
            VStack {
                Form {
                    Section(header: Text("Player 1")) {
                        Picker("Minutes", selection: $player1Minutes) {
                            ForEach(0..<60) {
                                Text("\($0)")
                            }
                        }
                        
                        Picker("Seconds", selection: $player1Seconds) {
                            ForEach(0..<60) {
                                Text("\($0)")
                            }
                        }
                        
                        Picker("Increment", selection: $player1Increment) {
                            ForEach(0..<6) {
                                Text("\($0)")
                            }
                        }
                    }
                    
                    Section(header: Text("Player 2")) {
                        
                        Toggle(isOn: $player2Same) {
                            Text("Same as player 1")
                                .bold()
                        }
                        
                            Picker("Minutes", selection: $player2Minutes) {
                                ForEach(0..<60) {
                                    Text("\($0)")
                                }
                            }.disabled(player2Same)
                            
                            Picker("Seconds", selection: $player2Seconds) {
                                ForEach(0..<60) {
                                    Text("\($0)")
                                }
                            }.disabled(player2Same)
                            
                            Picker("Increment", selection: $player2Increment) {
                                ForEach(0..<6) {
                                    Text("\($0)")
                                }
                            }.disabled(player2Same)
                    }
                    
                    Button("Done") {
                        
                        model.counterPlayer1 = TimeFormat.settingsIntoSeconds(minutes: player1Minutes, seconds: player1Seconds)
                        model.increment1 = player1Increment
                        
                        if player2Same {
                            model.counterPlayer2 = model.counterPlayer1
                            model.increment2 = model.increment1
                        } else {
                            model.counterPlayer2 = TimeFormat.settingsIntoSeconds(minutes: player2Minutes, seconds: player2Seconds)
                            model.increment2 = player2Increment
                        }

                        dismiss()
                    }
                }
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ClockModel())
    }
}

