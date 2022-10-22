//
//  Network.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import Foundation
import Combine

enum NetworkError: Error {
    case bearerToken
}

struct Network {
    // MARK: - API Calls
    func getRestrooms(type: String, zipcode: String) -> AnyPublisher<[RestroomModel], Never> {
        let parameters: [String: Any] = ["term": type, "location": zipcode, "limit": "10", "attributes": "gender_neutral_restrooms"]
        
        guard let bearerToken: String = Bundle.main.infoDictionary?["BEARER_TOKEN"] as? String else {
            return Just([]).eraseToAnyPublisher()
        }
        let header: [String: String] = ["Authorization": bearerToken]
        
        let urlRequest: URLRequest = networkRequest(baseURL: "https://api.yelp.com", endpoint: GNRRestroomEndpoint.GetRestrooms, parameters: parameters, headers: header)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: YelpBusinessModel.self, decoder: JSONDecoder())
            .map(\.businesses)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    // MARK: - Networking
    private func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> URLRequest {
        var components = URLComponents(string: baseURL + endpoint.path)!
        guard let parameters = parameters else {
            return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
    }
    
    private func requestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        headers?.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }
        return request as URLRequest
    }
}
