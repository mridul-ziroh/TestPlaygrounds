//
//  MatchCentreView.swift
//  App
//
//  Created by mridul-ziroh on 06/04/25.
//


//
//  MatchCentreView.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//
import Foundation
import SwiftUI

struct MatchCentreView: View {
    @StateObject var viewModel: MatchViewModel
    
    var body: some View {
        NavigationView{
            VStack(spacing: 40) {
                
                team1ScoreBoard
                team2ScoreBoard
                Group {
                    if let winner = viewModel.winner {
                        Text("\(winner.name) Wins")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .bold()
                    } else {
                        if let outcome = viewModel.lastBallResult {
                            Text("\(outcome.description)")
                                .foregroundStyle(.black)
                                .font(.largeTitle)
                                .bold()
                        } else {
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.gray)
                
                Button {
                    viewModel.playNextBall()
                } label: {
                    HStack{
                        Text("Play Next Ball")
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.green)
                }
            }
        }
        .navigationTitle("Match Center")
        .ignoresSafeArea()
    }
    
    var team1ScoreBoard: some View {
        VStack(spacing: 40){
            Text("\(viewModel.team1.name) (\(viewModel.isFirstInnings ? "Batting" : "Bowling"))")
                .bold()
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("Score: \(viewModel.team1Innings.runs)/\(viewModel.team1Innings.wickets)")
                Spacer()
                Text("Overs: \(viewModel.team1Innings.oversFormatted)")
            }
        }
        .padding(.horizontal)
    }
    
    var team2ScoreBoard: some View {
        VStack(spacing: 40){
            Text("\(viewModel.team2.name) (\(viewModel.isFirstInnings ? "Bowling" : "Batting"))")
                .bold()
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            if viewModel.isFirstInnings {
                HStack {
                    Text("yet to bat")
                    Spacer()
                    Text("yet to bat")
                    
                }
            } else {
                HStack {
                    Text("Score: \(viewModel.team2Innings.runs)/\(viewModel.team2Innings.wickets)")
                    Spacer()
                    Text("Overs: \(viewModel.team2Innings.oversFormatted)")
                }
            }
        }.padding(.horizontal)
        
    }
    
}

#Preview {
    MatchCentreView(viewModel:
                        MatchViewModel(team1: Team(name: "Afghanistan",
                                                   flag: "https://img.cricketworld.com/images/d-046469/afghanistan.jpg"),
                                       team2: Team(name: "Afghanistan",
                                                   flag: "https://img.cricketworld.com/images/d-046469/afghanistan.jpg"))
    )
}
