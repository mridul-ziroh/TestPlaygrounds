//
//  MatchViewModel.swift
//  App
//
//  Created by mridul-ziroh on 06/04/25.
//


//
//  MatchViewModel.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//

import Foundation

class MatchViewModel: ObservableObject {
    @Published var team1: Team
    @Published var team2: Team
    @Published var team1Innings = CurrentInning()
    @Published var team2Innings = CurrentInning()
    @Published var isFirstInnings = true
    @Published var lastBallResult: BallResult? = nil
    @Published var winner: Team?

    init(team1: Team, team2: Team) {
        self.team1 = team1
        self.team2 = team2
    }

    func playNextBall() {
        guard winner == nil else { return }

        let result = BallResult.random()
        lastBallResult = result

        if isFirstInnings {
            updateInnings(&team1Innings, result)
            if team1Innings.isOver {
                isFirstInnings = false
            }
        } else {
            updateInnings(&team2Innings, result)
            if team2Innings.runs > team1Innings.runs {
                winner = team2
            } else if team2Innings.isOver {
                winner = team1Innings.runs > team2Innings.runs ? team1 : team2
            }
        }
    }

    private func updateInnings(_ innings: inout CurrentInning, _ result: BallResult) {
        innings.balls += 1
        switch result {
        case .out:
            innings.wickets += 1
        case .runs(let value):
            innings.runs += value
        }
    }
}
