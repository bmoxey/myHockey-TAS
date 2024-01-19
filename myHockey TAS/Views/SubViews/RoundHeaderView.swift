//
//  RoundHeaderView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 10/1/2024.
//

import SwiftUI

struct RoundHeaderView: View {
    var round: Rounds
    var first: Bool
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d MMM h:mm a"
    return dateFormatter.string(from: round.date)
    }
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d MMM"
    return dateFormatter.string(from: round.date)
    }
    var body: some View {
        HStack {
            if round.result != "No Result" && round.opponent != "Nobody" && first {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color("AccentColor"))
            }
            Spacer()
            Text(round.opponent == "Nobody" ? "\(round.roundNo) - \(shortDate)" : "\(round.roundNo) - \(formattedDate)")
                .foregroundStyle(Color("LightColor"))
//                .font(.footnote)
            Spacer()
            if round.result != "No Result" && round.opponent != "Nobody" && !first {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color("AccentColor"))
            }
        }
//        .frame(height: 10)
        .listRowBackground(Color("DarkColor1"))
    }
}

#Preview {
    RoundHeaderView(round: Rounds(), first: false)
}
