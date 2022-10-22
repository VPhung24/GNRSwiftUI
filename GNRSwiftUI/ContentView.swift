//
//  ContentView.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var restroomRequestViewModel = RestroomSearchViewModel()
    @State var isActive = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("type"),
                    footer: Text(restroomRequestViewModel.typeMessage).foregroundColor(.red)) {
                        TextField(
                            "ex sushi, fries, steak",
                            text: $restroomRequestViewModel.type
                        )
                        .autocapitalization(.none)
                    }
                Section(
                    header: Text("zipcode"),
                    footer: Text(restroomRequestViewModel.zipcodeMessage).foregroundColor(.red)) {
                        TextField(
                            "ex 10001",
                            text: $restroomRequestViewModel.zipcode
                        )
                        .keyboardType(.numberPad)
                    }
                NavigationLink(
                    "Find",
                    destination:
                        RestroomsView(type: restroomRequestViewModel.type, zipCode: restroomRequestViewModel.zipcode)
                )
                .disabled(!restroomRequestViewModel.isValid)
            }
            .navigationTitle("GNR: Restrooms for All")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
