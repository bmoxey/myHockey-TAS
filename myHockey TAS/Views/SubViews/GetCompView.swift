//
//  GetCompView.swift
//  myHockey TAS
//
//  Created by Brett Moxey on 7/1/2024.
//

import SwiftUI

struct GetCompView: View {
    @Binding var comps: [Teams]
    @Binding var myComp: Teams
    @State private var searchComp = "ALL"
    @State private var searchType = "ALL"

    var body: some View {
        let uniqueCompArray = comps.reduce(into: Set<String>()) { result, competition in result.insert(competition.compName)}.union(["ALL"]).sorted()
        let uniqueTypeArray = comps.reduce(into: Set<String>()) { result, competition in result.insert(competition.type)}.union(["ALL"]).sorted()
        Section(header: Text("Add team from competition...").foregroundStyle(Color("DarkColor1"))) {
            Picker("Competition:", selection: $searchComp) {
                ForEach(uniqueCompArray, id: \.self) {
                    Text($0)
                }
            }
            .foregroundColor(.white)
            .pickerStyle(.menu)
            .listRowBackground(Color("DarkColor1"))
            Picker("Type", selection: $searchType) {
                ForEach(uniqueTypeArray, id: \.self) {type in
                    Text(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowBackground(Color("DarkColor1").opacity(0.75))
            ForEach(comps) { comp in
                if comp.compName == searchComp || searchComp == "ALL" {
                    if comp.type == searchType || searchType == "ALL" {
                        HStack {
                            Text(comp.type)
                            Text(comp.divName)
                                .foregroundStyle(Color("DarkColor1"))
                                .onTapGesture { myComp = comp }
                        }
                        .listRowBackground(Color.white)
                    }
                }
            }
        }
    }
}

#Preview {
    GetCompView(comps: .constant([]), myComp: .constant(Teams()))
}
