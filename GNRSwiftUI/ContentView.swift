//
//  ContentView.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var lookupRestroomType: String = ""
    @State private var zipcode: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    TextField(
                        "Type",
                        text: $lookupRestroomType
                    )
                    TextField(
                        "Zipcode",
                        text: $zipcode
                    )
                    .keyboardType(.numberPad)
                }
                Section {
                    Button(action: {
                        print("Perform an action here...")
                    }) {
                        Text("Find")
                    }
                }
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
