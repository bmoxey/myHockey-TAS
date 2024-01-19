//
//  RoundSummaryView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 10/1/2024.
//

import SwiftUI

struct RoundSummaryView: View {
    var round: Rounds
    var timer = Timer()
    @State private var timeRemaining: TimeInterval = 0
    var body: some View {
        VStack {
            if round.opponent == "Nobody" {
                HStack {
                    Text(round.result == "BYE" ? "\(round.myTeam) has a BYE" : "No Game this week")
                    Spacer()
                    DateBoxView(date: round.date, fullDate: false)
                }
            } else {
                if Date() < round.date {
                    HStack {
                        Spacer()
                        Text("\(countdownString())")
                            .frame(alignment: .center)
                            .foregroundStyle(Color.red)
                            .onAppear {
                                timeRemaining = round.date.timeIntervalSinceNow
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                    timeRemaining = round.date.timeIntervalSinceNow
                                    if timeRemaining <= 0 { timer.invalidate() }
                                }
                            }
                        Spacer()
                    }
                }
                if round.result == "No Game" {
                    HStack {
                        Image(GetImage(teamName: round.opponent))
                            .resizable()
                            .frame(width: 75, height: 75)
                        Spacer()
                        VStack {
                            Text(round.opponent)
                                .multilineTextAlignment(.center)
                            Text("")
                            Text("@ \(round.field)")
                        }
                        Spacer()
                        DateBoxView(date: round.date, fullDate: true)
                    }
                } else {
                    HStack {
                        Text(round.homeTeam)
                            .fontWeight(round.homeTeam == round.myTeam ? .bold : .regular)
                            .multilineTextAlignment(.center)
                        Spacer()
                        Text("VS")
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .padding(.horizontal, 0)
                        Spacer()
                        Text(round.awayTeam)
                            .fontWeight(round.awayTeam == round.myTeam ? .bold : .regular)
                            .multilineTextAlignment(.center)
                    }
                    HStack {
                        Image(GetImage(teamName: round.homeTeam))
                            .resizable()
                            .frame(width: 75, height: 75)
                        Text("\(round.homeGoals)")
                            .fontWeight(round.homeTeam == round.myTeam ? .bold : .regular)
                            .font(.largeTitle)
                        Spacer()
                        Text(" \(round.result) ")
                            .foregroundStyle(Color.black)
                            .fontWeight(.bold)
                            .background(getColor(result: round.result))
                        Spacer()
                        Text("\(round.awayGoals)")
                            .fontWeight(round.awayTeam == round.myTeam ? .bold : .regular)
                            .font(.largeTitle)
                        Image(GetImage(teamName: round.awayTeam))
                            .resizable()
                            .frame(width: 75, height: 75)
                    }
                    HStack {
                        HStack {
                            if Int(round.homeGoals) ?? 0 > 0 {
                                Text(String(repeating: "●", count: Int(round.homeGoals) ?? 0))
                                    .foregroundStyle(round.homeTeam == round.myTeam ? Color.green : Color.red)
                                    .font(.system(size:20))
                                    .padding(.horizontal, 0)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                            }
                            Spacer()
                        }
                        .frame(width: 100)
                        Spacer()
                        Text("@ \(round.field)")
                        Spacer()
                        HStack {
                            Spacer()
                            if Int(round.awayGoals) ?? 0 > 0 {
                                Text(String(repeating: "●", count: Int(round.awayGoals) ?? 0 ))
                                    .foregroundStyle(round.awayTeam == round.myTeam ? Color.green : Color.red)
                                    .font(.system(size:20))
                                    .padding(.horizontal, 0)
                                    .multilineTextAlignment(.trailing)
                                    .lineLimit(nil)
                                
                            }
                        }
                        .frame(width: 100)
                    }
                }
            }
        }
        .listRowBackground(getColor(result: round.result).brightness(0.9))
        .foregroundStyle(Color.black)
    }
    private func getColor(result: String) -> Color {
        var col: Color
        col = Color("LightColor")
        if result == "Win" { col = Color(red: 0, green: 1, blue: 0) }
        if result == "Forfeit Win" { col = Color(red: 0, green: 1, blue: 0) }
        if result == "Force Loss Win" { col = Color(red: 0, green: 1, blue: 0) }
        if result == "Loss" { col = Color(red: 1, green: 0, blue: 0) }
        if result == "Forfeit Loss" { col = Color(red: 1, green: 0, blue: 0) }
        if result == "Forced Loss" { col = Color(red: 1, green: 0, blue: 0) }
        if result == "Draw" { col = Color(red: 1, green: 0.7, blue: 0) }
        if result == "No Game" && round.date < Date() { col = Color(red: 0, green: 0, blue: 0) }
        if result == "BYE" { col = Color(red: 0, green: 0, blue: 1) }
        return col
    }
    private func countdownString() -> String {
        let days = Int(timeRemaining) / (60 * 60 * 24)
        let hours = Int(timeRemaining) % (60 * 60 * 24) / 3600
        let minutes = Int(timeRemaining) % 3600 / 60
        let seconds = Int(timeRemaining) % 60
        if days > 0 { return String(format: "Game starts in %d days, %d hours", days, hours) }
        if hours > 0 { return String(format: "Game starts in %d hours, %d minutes", hours, minutes)}
        return String(format: "Game starts in %d minutes, %d seconds", minutes, seconds)
    }
}

#Preview {
    RoundSummaryView(round: Rounds())
}
