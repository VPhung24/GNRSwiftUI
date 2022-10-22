//
//  RestroomModel.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import Foundation

struct YelpBusinessModel: Identifiable, Codable {
    let businesses: [RestroomModel]
    let id = UUID()
}

struct RestroomModel: Identifiable, Codable {
    let name: String
    let url: String
    let imageURL: String
    let reviews: Int
    let location: LocationModel
    
    var id: String { url }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
        case imageURL = "image_url"
        case reviews = "review_count"
        case location
    }
    
    init(name: String, url: String, imageURL: String, reviews: Int, location: LocationModel) {
        self.name = name
        self.url = url
        self.imageURL = imageURL
        self.reviews = reviews
        self.location = location
    }
}

struct LocationModel: Codable {
    let address: String
    let city: String
    let zipcode: String
    let state: String

    enum CodingKeys: String, CodingKey {
        case address = "address1"
        case city
        case zipcode = "zip_code"
        case state
    }
}
