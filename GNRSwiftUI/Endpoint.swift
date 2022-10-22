//
//  Endpoint.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import Foundation

enum Method: String {
    case GET
    case POST
}

protocol Endpoint {
    var path: String { get }
    var method: Method { get }
}

// MARK: - GNRRestroomEndpoint
enum GNRRestroomEndpoint: Endpoint {
    case GetRestrooms
    
    var path: String {
        switch self {
        case .GetRestrooms:
            return "/v3/businesses/search"
        default:
            return ""
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .GET
        }
    }
}
