//
//  ContentView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex = 0
    @State var loading = false
    @StateObject private var teamsManager = TeamsManager()
    var body: some View {
        ZStack {
            tabItems[selectedIndex].viewName
                .environmentObject(teamsManager)
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    HStack(alignment: .bottom, spacing: 0){
                        ForEach(0..<5) { (index) in
                            let tab = tabItems[index]
                            VStack(spacing: 0) {
                                Spacer()
                                Rectangle()
                                    .foregroundColor( .clear )
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        ZStack {
                                            Image(systemName: tab.imageName)
                                                .font(.system(size: 24))
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(Color("AccentColor"),Color("LightColor"))
                                        }
                                    )
                                    .background(
                                        ZStack {
                                            Text(tab.title)
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundStyle(Color("LightColor"))
                                                .opacity(self.selectedIndex == index ? 1.0 : 0.0)
                                        }.offset(CGSize(width: 0, height: 32))
                                    )
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(height: self.selectedIndex == index ? 26 : 5)
                            }
                            .frame(width: proxy.size.width * 0.2)
                            .contentShape( Rectangle() )
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7) ) { self.selectedIndex = index }
                            }
                        }
                    }
                    .background(
                        Rectangle()
                            .frame(height: 24 + 49 + 40)
                            .overlay(
                                Circle()
                                    .foregroundColor(Color("DarkColor2"))
                                    .frame(width: 40, height: 40)
                                    .offset(CGSize(width: CGFloat(self.selectedIndex - 2) * (proxy.size.width * 0.2), height: -29))
                            )
                            .foregroundColor(Color("DarkColor1"))
                            .offset(CGSize(width: 0, height: 20))
                            .mask(
                                VStack(spacing: 0) {
                                    TopFrameView()
                                        .frame(width: 75, height: 24)
                                        .offset(CGSize(width: CGFloat(self.selectedIndex - 2) * (proxy.size.width * 0.2), height: 0))
                                    Rectangle()
                                        .frame(height: 49 + 40)
                                }.offset(CGSize(width: 0, height: 20))
                            ).shadow(color: Color("DarkColor1").opacity(1.0) , radius: 10, x: 0, y: 0)
                    ).frame(height: 24 + 49)
                }
            }.ignoresSafeArea(edges: [.trailing, .leading])
        }.background(Color("LightColor"))
        .onAppear {
            teamsManager.saveTeams()
        }
    }
}

#Preview {
    ContentView()
}
