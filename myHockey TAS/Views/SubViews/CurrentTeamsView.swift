//
//  CurrentTeamsView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 7/1/2024.
//

import SwiftUI

struct CurrentTeamsView: View {
    @EnvironmentObject private var teamsManager: TeamsManager
    @State private var myselectedTeamId: String
    init(teamsManager: TeamsManager) {
        _myselectedTeamId = State(initialValue: teamsManager.currentTeam.teamID)
    }
    var body: some View {
        Section(header: Text("My Teams").foregroundStyle(Color("DarkColor1"))) {
            ForEach(teamsManager.myTeams, id: \.id) { team in
                HStack {
                    Image(team.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.vertical, -8)
                    VStack {
                        HStack {
                            Text(team.divName)
                                .foregroundStyle(Color("DarkColor1"))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Text(team.teamName)
                                .foregroundStyle(Color("DarkColor1").opacity(0.75))
                            Spacer()
                        }
                    }
                    if myselectedTeamId == team.teamID || teamsManager.currentTeam.teamID == team.teamID {
                        Image(systemName: "star.fill")
                            .imageScale(.large)
                            .foregroundStyle(Color("DarkColor2"))
                    }
                }
                .listRowBackground(Color.white)
                .onTapGesture {
                    teamsManager.currentTeam = team
                    myselectedTeamId = team.teamID
                    teamsManager.saveTeams()
                }
            }
            .onDelete { indexSet in
                let teams = teamsManager.myTeams
                    for index in indexSet {
                        if teams[index].teamID == myselectedTeamId {
                            if let newSelectedTeam = teams.first(where: { $0.teamID != teams[index].teamID }) {
                                teamsManager.currentTeam = newSelectedTeam
                                myselectedTeamId = newSelectedTeam.teamID
                                teamsManager.saveTeams()
                            }
                        }
                    }
                    teamsManager.myTeams.remove(atOffsets: indexSet)
                    teamsManager.saveTeams()
            }
        }

    }
}
