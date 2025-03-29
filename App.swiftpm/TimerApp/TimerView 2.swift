import SwiftUI

struct TimerView: View {
    @State private var timerValue: TimeInterval = 0.0
    @State private var isRunning: Bool = false
    @State private var startTime: Date?
    @State private var accumulatedTime: TimeInterval = 0.0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text(String(format: "%.3f", timerValue)) // Show timer in 3 decimal places
                .font(.largeTitle)
                .padding()

            HStack {
                Button(isRunning ? "Pause" : (timerValue == 0 ? "Start" : "Resume")) {
                    if isRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()

                Button("Reset") {
                    resetTimer()
                }
                .buttonStyle(.bordered)
            }
        }
    }

    func startTimer() {
        startTime = Date() // Store the time when the timer starts
        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if let start = startTime {
                timerValue = accumulatedTime + Date().timeIntervalSince(start)
            }
        }
    }

    func pauseTimer() {
        isRunning = false
        if let start = startTime {
            accumulatedTime += Date().timeIntervalSince(start) // Store elapsed time
        }
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        pauseTimer()
        timerValue = 0.0
        accumulatedTime = 0.0
        startTime = nil
    }
}

#Preview {
    TimerView()
}
