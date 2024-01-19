//
//  SetupView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//

import SwiftUI

struct SetupView: View {
    @ObservedObject private var teamsManager = TeamsManager()
    @State private var comps: [Teams] = []
    @State private var myComp: Teams = Teams()
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Rectangle()
                    .frame(height: 32)
                List{
                    CurrentTeamsView(teamsManager: teamsManager)
                                .environmentObject(teamsManager)
                    if comps.isEmpty {
                        Text("Loading...")
                            .foregroundStyle(Color("DarkColor1"))
                            .listRowBackground(Color.white)
                            .task {comps = await getComps()}
                    } else {
                        if myComp.compName == "" {
                            GetCompView(comps: $comps, myComp: $myComp)
                        } else {
                            GetTeamView(myComp: $myComp)
                                .environmentObject(teamsManager)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                Rectangle()
                    .frame(height: 39)
            }
            .background(Color("DarkColor1").opacity(0.25))
        }
        VStack {
            HeaderView(image: "AppLogo", tabindex: 4)
            Spacer()
        }
    }
}

#Preview {
    SetupView()
}
