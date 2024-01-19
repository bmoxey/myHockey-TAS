//
//  CurrentTeams.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//

import Foundation

class TeamsManager: ObservableObject {
    @Published var currentTeam: Teams = Teams()
    @Published var myTeams: [Teams] = []

    init() {
        loadTeams()
    }

    func saveTeams() {
        do {
            var teamsToSave = myTeams
            teamsToSave.append(currentTeam)
            
            let data = try JSONEncoder().encode(teamsToSave)
            UserDefaults.standard.set(data, forKey: "currentTeams")
        } catch {
            print("Error encoding teams: \(error)")
        }
    }

    func loadTeams() {
        if let data = UserDefaults.standard.data(forKey: "currentTeams") {
            do {
                let decodedTeams = try JSONDecoder().decode([Teams].self, from: data)
                
                if let lastTeam = decodedTeams.last {
                    currentTeam = lastTeam
                }
                
                myTeams = Array(decodedTeams.dropLast())
            } catch {
                print("Error decoding teams: \(error)")
            }
        }
    }
}



