//
//  ContentView.swift
//  Stopwatch-iOS-app
//
//  Created by KIM SEOWOO on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timeManager = TimeManager()
    
    var body: some View {
        
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
        
            VStack {
                Spacer()
                Text(timeManager.timeString(from:timeManager.mainTime ))
                    .font(.system(size: 80))
                    .fontWeight(.ultraLight)
                    .foregroundStyle(.white)
                    .monospacedDigit() // 시간폭 고정
                
                HStack {
                    Button {
                        
                        if timeManager.isRunning {
                            // 랩 추가
                            timeManager.addLap()
                        } else {
                            // 리셋 
                            timeManager.resetTimer()
                        }
                        
                    } label: {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 90, height: 90)
                            .opacity(0.2)
                            .overlay() {
                                Text(timeManager.isRunning ? "Lap" : "Reset")
                                    .foregroundStyle(.white)
                            }
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        if timeManager.isRunning {
                            // 정지
                            timeManager.stopTimer()
                         
                        } else {
                            // 시작
                            timeManager.startTimer()
                          
                        }
                        
                    } label: {
                        Circle()
                            .foregroundColor(timeManager.isRunning ? .red : .green)
                            .frame(width: 90, height: 90)
                            .opacity(0.2)
                            .overlay() {
                                Text(timeManager.isRunning ? "Stop" : "Start")
                                    .foregroundStyle(timeManager.isRunning ? .red : .green)
                                
                            }
                    }
                   
                }
                .padding()
                
                // reversed된 값을 넘기냐, 상태를 넘기냐
                // 티나는 상태를 넘김, 로쉘은 값을 넘김
                // 이때, 로쉘 우려되는 것
                
                List {
                    ForEach(timeManager.laps.reversed()) { lap in
                        Text("Lap \(lap.index) \(timeManager.timeString(from: lap.time))")
                            .foregroundColor(timeManager.color(for: lap))
                    }
                 .listRowBackground(Color.black)
                }
                .background(.black)
                .scrollContentBackground(.hidden)
                
            }
            .padding(.top, 200)

        }
       
       
    }
       
}

#Preview {
    ContentView()
}
