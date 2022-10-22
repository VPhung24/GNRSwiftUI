//
//  RestroomSearchViewModel.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import Foundation
import Combine

class RestroomSearchViewModel: ObservableObject {
    private var cancellableSet = Set<AnyCancellable>()
    private var network = Network()
    
    @Published var type = ""
    @Published var zipcode = ""
    
    @Published var isValid = false
    @Published var typeMessage: String = ""
    @Published var zipcodeMessage: String = ""
    @Published var restrooms: [RestroomModel] = []
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
        isTypeValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : (self.type.count == 0 ? "" : "type must at least have 4 characters")
            }
            .assign(to: \.typeMessage, on: self)
            .store(in: &cancellableSet)
        
        isZipCodeValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : (self.type.count == 0 ? "" : "us zipcodes are 5 digits")
            }
            .assign(to: \.zipcodeMessage, on: self)
            .store(in: &cancellableSet)
    }
    
    private var isTypeValidPublisher: AnyPublisher<Bool, Never> {
        $type
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 4
            }
            .eraseToAnyPublisher()
    }
    
    private var isZipCodeValidPublisher: AnyPublisher<Bool, Never> {
        $zipcode
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count == 5 && (Int(input) != nil)
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isTypeValidPublisher, isZipCodeValidPublisher)
            .map { typeIsValid, zipcodeIsValid in
                return typeIsValid && zipcodeIsValid
            }
            .eraseToAnyPublisher()
    }
}
