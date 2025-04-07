//
//  BallResult.swift
//  App
//
//  Created by mridul-ziroh on 06/04/25.
//


//
//  BallResult.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//


enum BallResult: CustomStringConvertible {
    case runs(Int)
    case out

    var description: String {
        switch self {
        case .runs(let value): return "\(value)"
        case .out: return "OUT"
        }
    }

    static func random() -> BallResult {
        let options: [BallResult] = [
            .runs(0),.runs(0),.runs(0),.runs(0),
            .runs(1),.runs(1),.runs(1),
            .runs(2),.runs(2),
            .runs(3),
            .runs(4),.runs(4),
            .runs(6),
            .out
        ]
        
        return options.randomElement()!
    }
}
