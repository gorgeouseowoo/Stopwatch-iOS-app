//
//  TimeManager.swift
//  Stopwatch-iOS-app
//
//  Created by KIM SEOWOO on 7/19/24.
//

import Foundation
import SwiftUI

class TimeManager: ObservableObject {
    
    @Published var isRunning: Bool = false // 시간이 흐르는지
    @Published var timer: Timer? // timer가 nil인 상황 고려
    @Published var mainTime: TimeInterval = 0.0 // 현재 시간
    @Published var lapTime: TimeInterval = 0.0
    @Published var laps: [Lap] = []
    
   
    func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time - Double(minutes * 60) - Double(seconds)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    
    func startTimer() {
        isRunning = true
        lapTime = 0.0
        laps.append(Lap(index: laps.count + 1, time: lapTime))
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.mainTime += 0.01
            self.lapTime += 0.01
            if self.laps.last != nil {
                self.laps[self.laps.count - 1].time = self.lapTime
            }
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
//        timer = nil
    }
    
    func resetTimer() {
        isRunning = false
        mainTime = 0.0
        laps.removeAll()
    }
    
    func addLap() {
        lapTime = 0.0
        laps.append(Lap(index: laps.count + 1, time: lapTime)) 
        
    }
    func color(for lap: Lap) -> Color {
        
        // 마지막 lap에는 색상이 적용되면 안된다
        let lapsWithoutLast = laps.dropLast()
        
        guard lapsWithoutLast.count > 1 else {
            return .white
        }
    
        guard let minTime = lapsWithoutLast.map({ $0.time }).min(),
              let maxTime = lapsWithoutLast.map({ $0.time }).max() else {
            return .white
        }

        if lap.time == minTime {
            return .green
        } else if lap.time == maxTime {
            return .red
        } else {
            return .white
        }
    }
   
    
}
