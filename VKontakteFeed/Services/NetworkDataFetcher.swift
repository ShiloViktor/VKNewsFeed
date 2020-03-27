//
//  NetworkDataFetcher.swift
//  VKontakteFeed
//
//  Created by Виктор on 25.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: NetworkDataFetcherProtocol {
    
    let networkingProtocol: NetworkingProtocol
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        
        let params = ["filters": "post,photo"]
        
        networkingProtocol.request(from: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Request data error - \(error.localizedDescription)")
            }
            let decoded = self.JSONdecode(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
            
        }
        
        
    }
    
    private func JSONdecode<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
