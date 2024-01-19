//
//  RoundView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//

import SwiftUI

struct RoundView: View {
    @EnvironmentObject private var teamsManager: TeamsManager
    @State private var rounds: [Rounds] = []
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Rectangle()
                    .frame(height: 32)
                if teamsManager.myTeams.isEmpty {
                    Text("no teams")
                } else {
                    if let oneMinuteInFuture = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) {
                        if rounds.isEmpty || lastUpdate > oneMinuteInFuture {
                            LoadingView()
                            .task {
                                rounds = await getRounds(teamsManager: teamsManager)
                            }
                        } else {
                            List{
                            EmptyView()
                            }
                            .scrollContentBackground(.hidden)
                        }
                    }
                }
                Rectangle()
                    .frame(height: 39)
            }
            .background(Color("DarkColor1").opacity(0.25))
        }
        VStack {
            HeaderView(image: "AppLogo", tabindex: 2)
            Spacer()
        }
    }
}

#Preview {
    RoundView()
}
