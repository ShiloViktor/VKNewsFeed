//
//  WebImageView.swift
//  VKontakteFeed
//
//  Created by Виктор on 26.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            self.image = nil
            return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("From Cachex")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data, let response = response {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                    print("From internet")
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        task.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
}
