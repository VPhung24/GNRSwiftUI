//
//  RestroomView.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import SwiftUI

struct RestroomsView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        List(network.restrooms) {
            Text($0.name)
        }
        .onAppear {
            print(network.restrooms)
        }
    }
}

struct RestroomsViewController_Previews: PreviewProvider {
    static var previews: some View {
        RestroomsView()
    }
}
