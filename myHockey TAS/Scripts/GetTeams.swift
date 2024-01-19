//
//  GetTeams.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 7/1/2024.
//

import Foundation
func getTeams(myComp: Teams) async -> [Teams] {
    var teams: [Teams] = []
    var lines: [String] = []
    lines = GetUrl(url: "\(url)pointscores/\(myComp.compID)/&d=\(myComp.divID)")
    for i in 0 ..< lines.count {
        if lines[i].contains("\(url)teams/") {
            let teamID = lines[i].split(separator: "=")[2].trimmingCharacters(in: .punctuationCharacters)
            let image = GetImage(teamName: lines[i+1])
            teams.append(Teams(compName: myComp.compName, compID: myComp.compID, divName: myComp.divName, divID: myComp.divID, type: myComp.type, teamName: lines[i+1], teamID: teamID, image: image))
        }
    }
    return teams
}
