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
    
    var postIds = [Int]()
    
    private var feedResponse: FeedResponse?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    case .getFeed:
        fetcher.getFeed { (feedResponse) in
            self.feedResponse = feedResponse
            self.presentFeed()
            
        }
    case .revealPostIds(postId: let postId):
        postIds.append(postId)
        presentFeed()
    }
    
  }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(response: feedResponse, postIds: postIds))
    }
}
