//
//  PlayerView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 13/1/2024.
//

import SwiftUI

struct PlayerView: View {
    var player: Player
    var body: some View {
        HStack {
            if player.captain {
                Image(systemName: "star.circle")
                    .foregroundStyle(Color("AccentColor"))
            }
            if player.fillin {
                Image(systemName: "person.fill.badge.plus")
                    .foregroundColor(Color("AccentColor"))
            }
            Text(player.name)
                .foregroundStyle(Color("DarkColor1"))
            if player.goalie == 1 {
                Text("(GK)")
                    .foregroundStyle(Color("DarkColor1"))
            }
            if player.greenCards > 0 {
                Text(String(repeating: "▲", count: player.greenCards))
                    .font(.system(size:24))
                    .foregroundStyle(Color.green)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 0)
            }
            if player.yellowCards > 0 {
                Text(String(repeating: "■", count: player.yellowCards))
                    .font(.system(size:24))
                    .foregroundStyle(Color.yellow)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 0)
            }
            if player.redCards > 0 {
                Text(String(repeating: "●", count: player.redCards))
                .font(.system(size:24))
                .foregroundStyle(Color.red)
                .padding(.vertical, 0)
                .padding(.horizontal, 0)
            }
            Spacer()
            if player.goals > 0 {
                Text(String(repeating: "●", count: player.goals))
                .font(.system(size:20))
                .foregroundStyle(Color.green)
                .padding(.vertical, 0)
                .padding(.horizontal, 0)
            }
        }
        .listRowBackground(Color("LightColor"))
    }
}

#Preview {
    PlayerView(player: Player())
}
