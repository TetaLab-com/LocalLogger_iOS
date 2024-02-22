//
//  TimerHelper.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import Foundation

class TimerHelper {
    private var timer: Timer?
    private var isTimerRunning = false

    func startTimer(withInterval interval: TimeInterval, repeats: Bool = true, action: @escaping () -> Void) {
        if isTimerRunning {
            stopTimer()
        }

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { _ in
            action()
        }

        isTimerRunning = true
    }

    func stopTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }

    deinit {
        stopTimer()
    }
}
