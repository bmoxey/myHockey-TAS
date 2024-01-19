//
//  PlayersView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 13/1/2024.
//

import SwiftUI

struct PlayersView: View {
    @Binding var searchTeam: String
    @State var newTeam: String
    @State var myRound: Rounds
    @State private var players: [Player] = []

    var body: some View {
        HStack {
            Spacer()
            Text("Players")
            Spacer()
        }
        .listRowBackground(Color("DarkColor1"))
        .onAppear {
            if searchTeam == "" {
                searchTeam = newTeam
            }
            Task {
                players = await getPlayers(round: myRound)
            }
        }
        .onDisappear {
            searchTeam = ""
        }
        Picker("Team:", selection: $searchTeam) {
            Text(myRound.homeTeam)
                .tag(myRound.homeTeam)
            Text(myRound.awayTeam)
                .tag(myRound.awayTeam)
        }
        .foregroundColor(.white)
        .pickerStyle(SegmentedPickerStyle())
        .listRowBackground(Color("DarkColor1").opacity(0.75))
        ForEach(players, id:\.id) {player in
            if player.team == searchTeam {
                PlayerView(player: player)
            }
        }

    }
}

#Preview {
    PlayersView(searchTeam: .constant(""), newTeam: "", myRound: Rounds())
}
