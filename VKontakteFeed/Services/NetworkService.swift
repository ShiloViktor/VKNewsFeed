//
//  NetworkService.swift
//  VKontakteFeed
//
//  Created by Виктор on 24.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    func request(from path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: NetworkingProtocol {
  
    
    private let authService = AppDelegate.shared().authService
    
    func request(from path: String, params: [String : String],completion: @escaping (Data?, Error?) -> Void) {
        var allParams = params
        guard let token = authService?.token else { return }
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.getUrl(from: path, params: allParams)
        print(url)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func getUrl(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
}
