//
//  GetPlayers.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 12/1/2024.
//

import Foundation

func getPlayers(round: Rounds) async -> [Player] {
    var players: [Player] = []
    var myPlayer: Player = Player()
    var lines: [String] = []
    var homePlayer: Bool = false
    var attended: Bool = false
    lines = GetUrl(url: "\(url)game/\(round.gameID)/")
    for i in 0 ..< lines.count {
        if String(lines[i]) == round.homeTeam { homePlayer = true }
        if String(lines[i]) == round.awayTeam { homePlayer = false }
        if lines[i].contains("Attended") {attended = true}
        if lines[i].contains("Did not attend") {attended = false}
        if lines[i].contains("\(url)statistics/") && attended {
            myPlayer.name = lines[i+1]
            myPlayer.goals = Int(lines[i+7]) ?? 0
            myPlayer.greenCards = Int(lines[i+11]) ?? 0
            myPlayer.yellowCards = Int(lines[i+15]) ?? 0
            myPlayer.redCards = Int(lines[i+19]) ?? 0
            if homePlayer {myPlayer.team = round.homeTeam}
            else {myPlayer.team = round.awayTeam}
            players.append(myPlayer)
            myPlayer = Player()
        }
    }
    return players
}
