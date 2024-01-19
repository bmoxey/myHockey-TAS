//
//  HeaderView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 11/1/2024.
//

import SwiftUI

struct HeaderView: View {
    var image: String
    var tabindex: Int
    var body: some View {
        HStack {
            Image(systemName: tabItems[tabindex].imageName)
                .symbolRenderingMode(.palette)
                .font(.system(size: 30))
                .foregroundStyle(Color("AccentColor"),Color.white)
                .padding(.horizontal)
            Spacer()
            Text(tabItems[tabindex].fulltitle)
                .foregroundStyle(Color.white)
                .fontWeight(.bold)
            Spacer()
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.horizontal)
        }
        .background(Color("DarkColor1"))
        .shadow(color: Color("DarkColor1").opacity(1.0), radius: 10, x: 0, y: 0)
    }
}



#Preview {
    HeaderView(image: "AppIcon", tabindex: 1)
}
