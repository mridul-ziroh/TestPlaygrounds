//
//  AviatorViewModel.swift
//  App
//
//  Created by mridul-ziroh on 29/03/25.
//
import SwiftUI
import Foundation

class AviatorViewModel: ObservableObject,@unchecked Sendable {
    @Published var total: Double = 5000
    private var timerStart = false
    @Published var multiplier: Double  = 1.0
    @Published var isInvalid = false
    private var interval: TimeInterval = 1
    private var maxMultiplier : Double = 3.0
    
    func startMultiplier () {
        if !isInvalid {
            if timerStart {
                    total += 100 * multiplier
                maxMultiplier = -1.0
                timerStart = false
            } else {
                timerStart = true
                maxMultiplier = Double.random(in: 1.4..<3.6)
                total -= 100
            }
            Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                if self.multiplier < self.maxMultiplier {
                    self.multiplier += 0.1
                } else {
                    timer.invalidate()
                    self.isInvalid = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
                        self.multiplier = 1
                        self.isInvalid = false
                        self.timerStart = false
                    }
                }
            }
        } else {
            
        }
    }
}
