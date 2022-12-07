//
//  MainView.swift
//  ChessClock
//
//  Created by Szymon Kocowski on 21/09/2022.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @EnvironmentObject var model: ClockModel
    
    @State private var player1 = Player()
    @State private var player2 = Player()
    
    @State private var isRunning1 = false
    @State private var isRunning2 = false
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerSubscription: Cancellable?
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Button {
                            stopTimer()
                            startTimer()
                            player2.onEnd()
                            isRunning1.toggle()
                            isRunning2 = false
                        } label: {
                            ZStack(alignment: .bottomLeading) {
                                RectangleButton(value: $player2.remainingTime, style: isRunning2 ? .start : .pause)
                                
                                HStack {
                                    Text("Moves:")
                                        .font(.title)
                                    Text("\(player2.moves)")
                                        .font(.title)
                                        .bold()
                                }
                                .foregroundColor(isRunning2 ? Color.white : Color.black)
                                .offset(x: 10, y: -5)
                            }                        }
                        .rotationEffect(.degrees(-180))
                    }
                    .disabled(isRunning1 == true)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 100)
                            .foregroundColor(Color.black)
                        
                        HStack {
                            Spacer()
                            Button {
                                stopTimer()
                                loadSettings()
                                isRunning1 = false
                                isRunning2 = false
                                
                            } label: {
                                Image(systemName: "gobackward")
                                    .font(.largeTitle)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                SettingsView()
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .font(.largeTitle)
                                    .onAppear(perform: loadSettings)
                            }
                            Spacer()
                        }
                    }
                    
                    VStack {
                        Button {
                            stopTimer()
                            startTimer()
                            player1.onEnd()
                            isRunning2.toggle()
                            isRunning1 = false
                        } label: {
                            ZStack(alignment: .bottomLeading) {
                                RectangleButton(value: $player1.remainingTime, style: isRunning1 ? .start : .pause)
                                HStack {
                                    Text("Moves:")
                                        .font(.title)
                                    Text("\(player1.moves)")
                                        .font(.title)
                                        .bold()
                                }
                                .foregroundColor(isRunning1 ? Color.white : Color.black)
                                .offset(x: 10, y: -5)
                            }
                        }
                    }
                    .disabled(isRunning2 == true)
                }
                .padding(.vertical)
                .alert("Time out", isPresented: $player1.showingAlert) {
                    Button("OK") {
                        stopTimer()
                        isRunning1 = false
                        isRunning2 = false
                        loadSettings()
                    }
                } message: {
                    Text("Reset the clock")
                }
                .alert("Time out", isPresented: $player2.showingAlert) {
                    Button("OK") {
                        stopTimer()
                        isRunning1 = false
                        isRunning2 = false
                        loadSettings()
                    }
                } message: {
                    Text("Reset the clock")
                }
            }
        }
        .onAppear(perform: loadSettings)
        .onReceive(timer) { _ in
            onTimerCount()
        }
    }
    
    
    func loadSettings() {
        player1 = Player(remainingTime: model.counterPlayer1, increment: model.increment1)
        player2 = Player(remainingTime: model.counterPlayer2, increment: model.increment2)
    }
    
    func onTimerCount() {
        if isRunning1 {
            player1.decreaseTime(1)
        } else if isRunning2 {
            player2.decreaseTime(1)
        }
    }
    
    
    func startTimer() {
        if self.timerSubscription == nil {
            self.timer = Timer.publish(every: 1, on: .main, in: .common)
            self.timerSubscription = self.timer.connect()
        }
    }
    
    func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ClockModel())
    }
}
