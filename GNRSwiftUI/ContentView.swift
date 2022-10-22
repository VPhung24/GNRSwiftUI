//
//  ContentView.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    @State private var lookupRestroomType: String = ""
    @State private var zipcode: String = ""
    @State private var isActive: Bool = false
    
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
                    Button("Find") {
                        if !self.isActive {
                            network.findRestrooms(ofType: lookupRestroomType, atZipCode: zipcode)
                        }
                        self.isActive = true
                    }
                }
                
            }
            .navigationTitle("GNR: Restrooms for All")
//            NavigationLink("Restrooms", destination: RestroomsView().environmentObject(network), isActive: $isActive)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}
