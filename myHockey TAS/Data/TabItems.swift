//
//  TabItems.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//

import SwiftUI

struct TabItemDescription {
    var imageName: String
    var title: String
    var fulltitle: String
    var viewName: AnyView
}

let tabItems: [TabItemDescription] = [
    .init(imageName: "calendar.badge.clock", title: "Fixture", fulltitle: "Season Fixture", viewName: AnyView(FixtureView())),
    .init(imageName: "list.number", title: "Ladder", fulltitle: "Division Ladder", viewName: AnyView(LadderView())),
    .init(imageName: "clock.badge", title: "Round", fulltitle: "Round by Round", viewName: AnyView(RoundView())),
    .init(imageName: "chart.bar.xaxis", title: "Stats", fulltitle: "Statistics", viewName: AnyView(StatsView())),
    .init(imageName: "person.crop.circle.badge.questionmark", title: "Setup", fulltitle: "Teams Setup", viewName: AnyView(SetupView()))
]

