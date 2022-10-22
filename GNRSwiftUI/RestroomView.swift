//
//  RestroomView.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import SwiftUI
import Combine

struct RestroomsView: View {
    @ObservedObject var restroomViewModel: RestroomListViewModel
    
    init(type: String, zipCode: String) {
        self.restroomViewModel = RestroomListViewModel(type: type, zipcode: zipCode)
    }
    
    var body: some View {
        List(restroomViewModel.restrooms) {
            Text($0.name)
        }
    }
}

struct RestroomsViewController_Previews: PreviewProvider {
    static var previews: some View {
        RestroomsView(type: "dentist", zipCode: "94501")
    }
}
