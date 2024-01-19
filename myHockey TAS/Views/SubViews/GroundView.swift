//
//  GroundView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 13/1/2024.
//

import SwiftUI

struct GroundView: View {
    @State var myRound: Rounds
    @State var address: String = ""
    var body: some View {
        HStack {
            Spacer()
            Text("Players")
            Spacer()
        }
        .listRowBackground(Color("DarkColor1"))
        .onAppear {
            Task {
                address = await getGround(round: myRound)
            }
        }
    }
}

#Preview {
    GroundView(myRound: Rounds())
}
