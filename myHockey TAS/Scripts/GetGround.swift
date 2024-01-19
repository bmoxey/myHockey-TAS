//
//  GetGround.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 13/1/2024.
//

import Foundation

func getGround(round: Rounds) async -> String {
    var address: String = ""
    var lines: [String] = []
    lines = GetUrl(url: "\(url)game/\(round.gameID)/")
    for i in 0 ..< lines.count {
        
    }
    return address
}
