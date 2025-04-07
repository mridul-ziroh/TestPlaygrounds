//
//  CurrentInning.swift
//  App
//
//  Created by mridul-ziroh on 06/04/25.
//


//
//  Innings.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//


struct CurrentInning {
    var runs = 0
    var wickets = 0
    var balls = 0
    var totalBalls = 0
    let maxBalls = 12
    let maxWickets = 3

    var isOver: Bool {
        wickets >= maxWickets || balls >= maxBalls
    }

    var oversFormatted: String {
        let over = balls / 6
        let ball = balls % 6
        return "\(over).\(ball)"
    }
}
