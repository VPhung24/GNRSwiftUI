//
//  RestroomsViewModel.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import Foundation
import Combine

class RestroomListViewModel: ObservableObject {
    private var cancellableSet = Set<AnyCancellable>()
    private var network: Network = Network()
    
    @Published var restrooms: [RestroomModel] = []
    
    init(type: String, zipcode: String) {
        network.getRestrooms(type: type, zipcode: zipcode)
            .receive(on: DispatchQueue.main)
            .assign(to:  \.restrooms, on: self)
            .store(in: &cancellableSet)
    }
    
}
