//
//  TeamsListView.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//


import SwiftUI

struct TeamsListView: View {
    @StateObject private var viewModel = TeamsViewModel(MockedNetworkService.shared)
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.teams) { team in
                    HStack {
                        AsyncImage(url: URL(string: team.flag)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 25, height: 25)
                        
                        
                        Text(team.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        if viewModel.isSelected(team) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.toggleSelection(for: team)
                    }
                }
                .navigationTitle("Select Teams")
                
                
                NavigationLink(destination:
                                MatchCentreView(viewModel: MatchViewModel(team1: viewModel.selectedTeams.first!, team2: viewModel.selectedTeams.last!))) {
                    HStack {
                        Text("Start Match")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(viewModel.selectedTeams.count != 2 ? .gray : .green)
                }
                .disabled(viewModel.selectedTeams.count != 2)
            }
        }
        .onAppear() {
            let vm = viewModel
            Task{
                await vm.loadTeams()
            }
            
        }
    }
}
