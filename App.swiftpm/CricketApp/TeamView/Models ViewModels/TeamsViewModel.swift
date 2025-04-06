//
//  TeamsViewModel.swift
//  App
//
//  Created by mridul-ziroh on 06/04/25.
//


//
//  TeamsViewModel.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//


import Foundation


class TeamsViewModel: ObservableObject {
    nonisolated(unsafe) private let networkService: NetworkService
    @Published var teams: [Team] = []
    @Published var selectedTeams: [Team] = []
    
    
    init(_ networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadTeams() async {
        do {
            let fetchedTeams: [Team] = try await networkService.fetchData(from: "teams")
                teams += fetchedTeams
        } catch {
            //handle erroe here
        }
    }
    
    func toggleSelection(for team: Team) {
        if selectedTeams.contains(team) {
            selectedTeams.removeAll { $0 == team }
        } else if selectedTeams.count < 2 {
            selectedTeams.append(team)
        }
    }
    
    func isSelected(_ team: Team) -> Bool {
        selectedTeams.contains(team)
    }
}
