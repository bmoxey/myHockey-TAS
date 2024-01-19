//
//  GetFixtures.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 10/1/2024.
//

import Foundation

@MainActor
func getFixtures(teamsManager: TeamsManager) async -> [Rounds] {
    teamsManager.loadTeams()
    try? await Task.sleep(nanoseconds: 200_000_000)
    var rounds: [Rounds] = []
    var myRound: Rounds = Rounds()
    var lines: [String] = []
    var score: String = ""
    var FL = false
    var FF = false
    var lastDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = " E dd MMM yyyy HH:mm "
    myRound.myTeam = teamsManager.currentTeam.teamName
    lines = GetUrl(url: "\(url)teams/\(teamsManager.currentTeam.compID)/&t=\(teamsManager.currentTeam.teamID)")
    for i in 0 ..< lines.count - 2 {
        if let dateTime = dateFormatter.date(from: lines[i] + " " + lines[i+2]) {
            myRound.date = dateTime
            myRound.roundNo = lines[i-4]
        }
        if lines[i].contains("\(url)venues/") {
            myRound.venue = lines[i+1]
            myRound.field = lines[i+5]
        }
        if lines[i].contains("have a BYE.") {
            myRound.result = "BYE"
            myRound.opponent = "Nobody"
        }
        if lines[i].contains("\(url)teams/") {
            myRound.opponent = lines[i+1]
            score = lines[i+5]
            myRound.result = lines[i+9]
            if lines[i+7] == "FF" || lines[i+7] == "FL" {
                score = lines[i+9]
                myRound.result = lines[i+13]
            }
            if score.contains("-") {
                let myScore = score.components(separatedBy: "-")
                myRound.homeGoals = myScore[0].trimmingCharacters(in: .whitespaces)
                myRound.awayGoals = myScore[1].trimmingCharacters(in: .whitespaces)
            }
            if myRound.result == "/div" { myRound.result = ""}
        }
        if lines[i].contains("badge badge-danger") && lines[i+1] == "FF" {FF = true}
        if lines[i].contains("badge badge-warning") && lines[i+1] == "FL" {FL = true}
        if lines[i].contains("\(url)game/") {
            if myRound.result != "" {
                (myRound.homeTeam, myRound.awayTeam) = GetHomeTeam(result: myRound.result, homeGoals: myRound.homeGoals, awayGoals: myRound.awayGoals, myTeam: teamsManager.currentTeam.teamName, opponent: myRound.opponent, rounds: rounds, venue: myRound.venue)
                if FL == true && myRound.result == "Loss" { myRound.result = "Forced Loss" }
                if FL == true && myRound.result == "Win" { myRound.result = "Force Loss Win" }
                if FF == true && myRound.result == "Loss" { myRound.result = "Forfeit Loss" }
                if FF == true && myRound.result == "Win" { myRound.result = "Forfeit Win" }
            }
            myRound.gameID = String(String(lines[i]).split(separator: "/")[3])
            myRound.id = UUID()
            if !rounds.isEmpty {
                let weeksBetweenDates = weekDatesBetween(lastDate: lastDate, endDate: myRound.date)
                for date in weeksBetweenDates {
                    var blankEntry = Rounds()
                    blankEntry.id = UUID()
                    blankEntry.date = date
                    blankEntry.myTeam = teamsManager.currentTeam.teamName
                    blankEntry.homeTeam = teamsManager.currentTeam.teamName
                    blankEntry.homeTeam = GetImage(teamName: teamsManager.currentTeam.teamName)
                    blankEntry.result = "No Game"
                    blankEntry.roundNo = "No Game"
                    blankEntry.opponent = "Nobody"
                    rounds.append(blankEntry)
                }
            }
            lastDate = myRound.date
            if myRound.result == "" { myRound.result = "No Game"}
            myRound.divName = teamsManager.currentTeam.divName
            rounds.append(myRound)
            myRound = Rounds()
            myRound.myTeam = teamsManager.currentTeam.teamName
            FL = false
            FF = false
        }
    }
    return rounds
}
