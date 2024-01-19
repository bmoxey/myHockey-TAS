//
//  GetRounds.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 8/1/2024.
//

import Foundation

func getRounds(teamsManager: TeamsManager) async -> [Rounds] {
    try? await Task.sleep(nanoseconds: 200_000_000)
    var roundFiles: [RoundFile] = []
    var myRoundFile: RoundFile = RoundFile()
    var rounds: [Rounds] = []
    var myRound: Rounds = Rounds()
    var lines: [String] = []
    var byes: Bool = false
    var byeTeams = [String]()
    var scores = ""
    for team in teamsManager.myTeams {
        lines = GetUrl(url: "\(url)games/\(team.compID)/&d=\(team.divID)")
        for i in 0 ..< lines.count {
            if lines[i].contains("\(url)games/") {
                myRoundFile.compName = team.compName
                myRoundFile.compID = team.compID
                myRoundFile.divName = team.divName
                myRoundFile.divID = team.divID
                myRoundFile.roundNo = lines[i+2]
                myRoundFile.roundURL = String(lines[i].split(separator: "\"")[1]).replacingOccurrences(of: "&amp;", with: "&")
                roundFiles.append(myRoundFile)
                myRoundFile = RoundFile()
            }
        }
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = " E dd MMM yyyy HH:mm "
    for round in roundFiles {
        byes = false
        lines = GetUrl(url: round.roundURL)
        for i in 0 ..< lines.count-2 {
            if lines[i].contains("BYEs") { byes = true }
            if let dateTime = dateFormatter.date(from: lines[i] + " " + lines[i+2]) {
                print(dateFormatter.string(from: dateTime))
            }
            if lines[i].contains("\(url)venues/") {
                myRound.venue = lines[i+1]
                myRound.field = lines[i+5]
                print(myRound.venue)
            }
             if lines[i].contains("\(url)teams/") {
                 if byes {
                     byeTeams.append(lines[i+1])
                 } else {
                     if myRound.homeTeam == "" {
                         myRound.homeTeam = lines[i+1]
                         scores = lines[i+5]
                         if scores == "FF" || scores == "FL" {
                             if scores == "FF" { myRound.message = "Forefeit"}
                             if scores == "FL" { myRound.message = "Forced Loss"}
                             scores = lines[i+12]
                         }
                         if lines[i+13] == "FF" { myRound.message = "Forefeit"}
                         if lines[i+13] == "FL" { myRound.message = "Forced Loss"}
                     } else {
                         if myRound.awayTeam == "" {
                             myRound.awayTeam = lines[i+1]
                             (myRound.homeGoals, myRound.awayGoals) = GetScores(scores: scores, seperator: "vs")
                             if scores == "/div" {
                                 if myRound.message == "" { myRound.message = "No results available." }
                                 myRound.result = "No Game"
                             } else {
                                 if myRound.homeGoals == myRound.awayGoals {
                                     myRound.result = "drew with"
                                 } else {
                                     if myRound.homeGoals > myRound.awayGoals {
                                         myRound.result = "defeated"
                                     } else {
                                         myRound.result = "lost to"
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
             if lines[i].contains("\(url)game/") {
                 myRound.gameID = String(lines[i].split(separator: "/")[3])
                 myRound.id = UUID()
                 rounds.append(myRound)
                 myRound = Rounds()
             }
         }
     }
    return rounds
}
