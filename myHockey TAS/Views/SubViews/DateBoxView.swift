//
//  DateBoxView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 11/1/2024.
//

import SwiftUI

struct DateBoxView: View {
    var date: Date
    var fullDate: Bool
    var myDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
    var myString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date)
    }
    var myTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    var body: some View {
        VStack {
            if fullDate {
                Text("\(myDay)")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(GetColor(dow: myDay))
                    .padding(.top, -2)
                Text("\(myTime)")
                    .foregroundStyle(Color("DarkColor1"))
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .padding(.vertical, 1)
                Text("\(myString)")
                    .font(.system(size: 13))
                    .foregroundStyle(Color("DarkColor1"))
            } else {
                Text("\(myDay)")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(GetColor(dow: myDay))
                    .padding(.top, -4)
                Text("\(myString)")
                    .foregroundStyle(Color("DarkColor1"))
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .padding(.top, 1)
                    .padding(.bottom, 20)
            }
                
        }
        .frame(width: 75, height: 75)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
    }
    func GetColor(dow: String) -> Color {
        if dow == "Mon" {return Color.orange}
        if dow == "Tue" {return Color.yellow}
        if dow == "Wed" {return Color.green}
        if dow == "Thur" {return Color.teal}
        if dow == "Fri" {return Color.blue}
        if dow == "Sat" {return Color.purple}
        if dow == "Sun" {return Color.red}
        else {return Color.yellow}
    }
}
#Preview {
    DateBoxView(date: Date(), fullDate: false)
}
