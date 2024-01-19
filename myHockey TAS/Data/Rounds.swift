//
//  Rounds.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 8/1/2024.
//

import Foundation

var rounds: [Rounds] = []
var lastUpdate: Date = Date()

struct RoundFile: Codable, Identifiable {
    var id: UUID
    var roundNo: String
    var roundURL: String
    var compName: String
    var compID: String
    var divName: String
    var divID: String
    
    init() {
        self.id = UUID()
        self.roundNo = ""
        self.roundURL = ""
        self.compName = ""
        self.compID = ""
        self.divName = ""
        self.divID = ""
    }
}

struct Rounds: Codable, Identifiable {
    var id: UUID
    var roundNo: String
    var date: Date
    var field: String
    var venue: String
    var address: String
    var myTeam: String
    var opponent: String
    var homeTeam: String
    var awayTeam: String
    var homeGoals: String
    var awayGoals: String
    var message: String
    var result: String
    var played: String
    var gameID: String
    var divName: String
    
    init() {
        self.id = UUID()
        self.roundNo = ""
        self.date = Date()
        self.field = ""
        self.venue = ""
        self.address = ""
        self.myTeam = ""
        self.opponent = ""
        self.homeTeam = ""
        self.awayTeam = ""
        self.homeGoals = ""
        self.awayGoals = ""
        self.message = ""
        self.result = ""
        self.played = ""
        self.gameID = ""
        self.divName = ""
    }
}
