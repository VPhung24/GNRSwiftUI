//
//  RestroomView.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import SwiftUI

struct RestroomsView: View {
    @State var restrooms: [RestroomModel]
    
    var body: some View {
        List(restrooms) {
            Text($0.name)
        }
    }
}

struct RestroomsViewController_Previews: PreviewProvider {
    static var previews: some View {
        RestroomsView(
            restrooms:
                [
                    RestroomModel(name: "Example 1", url: "blah"),
                    RestroomModel(name: "Example 2", url: "blah"),
                    RestroomModel(name: "Example 3", url: "blah"),
                    RestroomModel(name: "Example 4", url: "blah"),
                    RestroomModel(name: "Example 5", url: "blah")
                ]
        )
    }
}
