//
//  FixtureView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//t

import SwiftUI

struct FixtureView: View {
    @ObservedObject private var teamsManager = TeamsManager()
    @State private var rounds: [Rounds] = []
    @State private var myRound: Rounds = Rounds()
    @State private var currentWeek: Int?
    @State private var searchTeam: String = ""
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Rectangle()
                    .frame(height: 32)
                if rounds.isEmpty {
                    VStack {
                        Spacer()
                        Text("Loading...")
                            .foregroundStyle(Color("DarkColor1"))
                            .font(.largeTitle)
                            .task {rounds = await getFixtures(teamsManager: teamsManager)}
                        Spacer()
                        Image("AppPic")
                            .resizable()
                            .frame(width: 400, height: 400)
                        Spacer()
                    }
                } else {
                    ScrollViewReader { proxy in
                        List{
                            if myRound.gameID != "" {
                                Text(myRound.divName)
                                    .foregroundStyle(Color("AccentColor"))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .listRowBackground(Color("DarkColor2"))
                                Section() {
                                    RoundHeaderView(round: myRound, first: true)
                                        .onTapGesture { myRound = Rounds() }
                                    RoundSummaryView(round: myRound)
                                        .onTapGesture { myRound = Rounds() }
                                }
                                if myRound.result != "No Game" && myRound.opponent != "Nobody" {
                                    PlayersView(searchTeam: $searchTeam, newTeam: teamsManager.currentTeam.teamName, myRound: myRound)
                                }
                                if myRound.result == "No Game" && myRound.opponent != "Nobody" {
                                    GroundView(myRound: myRound)
                                }
                            } else {
                                Text(rounds[0].divName)
                                    .foregroundStyle(Color("AccentColor"))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .listRowBackground(Color("DarkColor2"))
                                ForEach(rounds, id:\.id) {round in
                                    Section() {
                                        RoundHeaderView(round: round, first: false)
                                            .onTapGesture { myRound = round }
                                        RoundSummaryView(round: round)
                                            .id(Calendar.current.component(.weekOfYear, from: round.date))
                                            .onTapGesture { myRound = round }
                                    }
                                    .onAppear {
                                        if currentWeek == nil {
                                            proxy.scrollTo(Calendar.current.component(.weekOfYear, from: Date()), anchor: .top)
                                            currentWeek = Calendar.current.component(.weekOfYear, from: Date())
                                        }
                                    }
                                }
                            }
                        }
                        .shadow(color: Color("DarkColor1").opacity(0.5), radius: 6, x: 4, y: 2)
                        .scrollContentBackground(.hidden)
                    }
                }
                Rectangle()
                    .frame(height: 39)
            }
            .background(Color("DarkColor1").opacity(0.25))
        }
        VStack {
            HeaderView(image: rounds.isEmpty ? "AppLogo" : GetImage(teamName: rounds[0].myTeam), tabindex: 0)
            Spacer()
        }
    }
}

#Preview {
    FixtureView()
}
