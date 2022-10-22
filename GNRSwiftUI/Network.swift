//
//  Network.swift
//  GNRSwiftUI
//
//  Created by Vivian Phung on 10/22/22.
//

import Foundation

class Network: ObservableObject {
    @Published var restrooms: [RestroomModel] = []
    
    private let twitterAPIURL = "https://api.yelp.com"
    
    // MARK: - API Calls
    func findRestrooms(ofType type: String, atZipCode zipcode: String) {
        let parameters: [String: Any] = ["term": type, "location": zipcode, "limit": "10", "attributes": "gender_neutral_restrooms"]
        
        guard let bearerToken: String = Bundle.main.infoDictionary?["BEARER_TOKEN"] as? String else { return }
        let header: [String: String] = ["Authorization": bearerToken]
        
        let urlRequest: URLRequest = networkRequest(baseURL: twitterAPIURL, endpoint: GNRRestroomEndpoint.GetRestrooms, parameters: parameters, headers: header)
        networkTask(request: urlRequest) { [weak self] (response: YelpBusinessModel?, error) in
            guard let businessModel = response else { return }
            DispatchQueue.main.async {
                self?.restrooms = businessModel.businesses
            }
        }
    }
    
    // MARK: - Networking
    func networkRequest(baseURL: String, endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> URLRequest {
        var components = URLComponents(string: baseURL + endpoint.path)!
        guard let parameters = parameters else {
            return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        return requestBuilder(url: components.url!, endpoint: endpoint, headers: headers)
    }
    
    func requestBuilder(url: URL, endpoint: Endpoint, headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        headers?.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }
        return request as URLRequest
    }
    
    func networkTask<T: Codable>(request: URLRequest, completionHandler: @escaping (T?, Error?) -> Void) {
        let session: URLSession = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let responseData = data, error == nil else {
                completionHandler(nil, error)
                return
            }
                        
            let decoder = JSONDecoder()
            do {
                let jsonData: T = try decoder.decode(T.self, from: responseData)
                completionHandler(jsonData, nil)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
             } catch let error { // catches decoding error from the try
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
