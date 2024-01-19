//
//  LoadingView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 6/1/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                Image("AppText")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width*2/3)
                Image("AppPic")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .background(Color("DarkColor1").opacity(0.25))
        }
    }
}

#Preview {
    LoadingView()
}
