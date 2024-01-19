//
//  myHockey_TASApp.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//

import SwiftUI

@main
struct myHockey_TASApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(TeamsManager())
        }
    }
}
