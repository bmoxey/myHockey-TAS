//
//  Competitions.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 7/1/2024.
//

import Foundation

var url = "https://www.hockeytasmania.com.au/"

class Teams: Identifiable, ObservableObject, Equatable, Encodable, Decodable {
    static func == (lhs: Teams, rhs: Teams) -> Bool {
        lhs.compName == rhs.compName
    }
    let id: UUID
    let compName: String
    let compID: String
    let divName: String
    let divID: String
    let type: String
    let teamName: String
    let teamID: String
    let image: String
    
    init(id: UUID = UUID(), compName: String = "", compID: String = "", divName: String = "", divID: String = "", type: String = "", teamName: String = "", teamID: String = "", image: String = "", isSelected: Bool = false) {
            self.id = id
            self.compName = compName
            self.compID = compID
            self.divName = divName
            self.divID = divID
            self.type = type
            self.teamName = teamName
            self.teamID = teamID
            self.image = image
        }
}
