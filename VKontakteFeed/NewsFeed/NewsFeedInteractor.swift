//
//  NewsFeedInteractor.swift
//  VKontakteFeed
//
//  Created by Виктор on 25.03.2020.
//  Copyright (c) 2020 Виктор. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    private var fetcher: NetworkDataFetcherProtocol = NetworkDataFetcher(networkingProtocol: NetworkService())

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    case .getFeed:
        fetcher.getFeed { (feedResponse) in
            guard let response = feedResponse else { return }
            self.presenter?.presentData(response: .presentNewsFeed(response: response))
        }
    }
    
  }
  
}
