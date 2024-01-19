//
//  GetTeamView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 7/1/2024.
//

import SwiftUI

struct GetTeamView: View {
    @EnvironmentObject private var teamsManager: TeamsManager
    @Binding var myComp: Teams
    @State var teams: [Teams] = []
    var body: some View {
        Section(header: Text("Select your team").foregroundStyle(Color("DarkColor1"))) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(Color("AccentColor"))
                Text(myComp.compName)
                    .foregroundStyle(Color.white)
            }
            .listRowBackground(Color("DarkColor1"))
            .onTapGesture {
                myComp = Teams()
            }
            HStack {
                Text(myComp.type)
                Text(myComp.divName)
                    .foregroundStyle(Color.white)
            }
            .listRowBackground(Color("DarkColor1").opacity(0.75))
            .onAppear() {
                Task {
                    teams = []
                    teams = await getTeams(myComp: myComp)
                }
            }
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], spacing: 10) {
                ForEach(teams, id: \.id) { team in
                    VStack {
                        Image(team.image)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal)
                        Text(team.teamName)
                            .foregroundStyle(Color("DarkColor1"))
                            .multilineTextAlignment(.center)
                    }
                    .onTapGesture {
                        if !teamsManager.myTeams.contains(where: { $0.teamID == team.teamID }) {
                            if teamsManager.myTeams.isEmpty { teamsManager.currentTeam = team }
                            teamsManager.myTeams.append(team)
                            teamsManager.saveTeams()
                            myComp = Teams()
                        }
                    }
                }
            }
            .listRowBackground(Color.white)
        }
    }
}

#Preview {
    GetTeamView(myComp: .constant(Teams()))
}
