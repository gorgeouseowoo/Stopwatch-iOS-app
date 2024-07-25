//
//  LapPresenter.swift
//  Stopwatch-iOS-app
//
//  Created by KIM SEOWOO on 7/18/24.
//

import Foundation

struct Lap: Identifiable {
    let id = UUID()
    let index: Int
    var time: TimeInterval
}
