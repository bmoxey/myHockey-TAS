//
//  General.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 7/1/2024.
//

import Foundation

func GetImage(teamName: String) -> String {
    var image: String = ""
    for club in clubs {
        if teamName.contains(club.clubName) {
            image = club.clubName
        }
    }
    return image
}

func GetScores(scores: String, seperator: String) -> (String, String) {
    var homeScore = ""
    var awayScore = ""
    if scores.contains(seperator) {
        let myScores = scores.components(separatedBy: seperator)
        homeScore = myScores[0].trimmingCharacters(in: .whitespaces)
        awayScore = myScores[1].trimmingCharacters(in: .whitespaces)
    }
    return (homeScore, awayScore)
}

func GetHomeTeam(result: String, homeGoals: String, awayGoals: String, myTeam: String, opponent: String, rounds: [Rounds], venue: String) -> (String, String) {
    var homeTeam = myTeam
    var awayTeam = ""
    if result == "Win" {
        if Int(homeGoals) ?? 0 > Int(awayGoals) ?? 0 {
            homeTeam = myTeam
            awayTeam = opponent
        } else {
            homeTeam = opponent
            awayTeam = myTeam
        }
    }
    if result == "Loss" {
        if Int(homeGoals) ?? 0 > Int(awayGoals) ?? 0 {
            homeTeam = opponent
            awayTeam = myTeam
        } else {
            homeTeam = myTeam
            awayTeam = opponent
        }
    }
    if result == "Draw" {
        let venueFrequency = rounds.reduce(into: [:]) { counts, round in
            counts[round.venue, default: 0] += 1
        }
        if let mostCommonVenue = venueFrequency.max(by: { $0.value < $1.value })?.key {
            if venue == mostCommonVenue {
                homeTeam = myTeam
                awayTeam = opponent
            } else {
                homeTeam = opponent
                awayTeam = myTeam
            }
        } else {
            homeTeam = opponent
            awayTeam = myTeam
        }
    }
    return (homeTeam, awayTeam)
}

func weekDatesBetween(lastDate: Date, endDate: Date) -> [Date] {
    var dates: [Date] = []
    var currentDate = Calendar.current.date(byAdding: .day, value: 10, to: lastDate)!
    while currentDate <= endDate {
        dates.append(Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!)
        currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
    }

    return dates
}
