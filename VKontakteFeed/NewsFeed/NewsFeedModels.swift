//
//  NewsFeedModels.swift
//  VKontakteFeed
//
//  Created by Виктор on 25.03.2020.
//  Copyright (c) 2020 Виктор. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getFeed
        case revealPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(response: FeedResponse, postIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(viewModel: FeedViewModel)
      }
    }
    }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int 
    
    var iconUrlImageView: String
    var name: String
    var date: String
    var text: String?
    var likes: String?
    var comments: String?
    var shares: String?
    var views: String?
    var postPhoto: FeedCellPhotoViewModel?
    var sizes: FeedCellSizes
    }
    
    struct FeedcellPhotoAttachment: FeedCellPhotoViewModel {
        var imageUrl: String? 
        var height: Int
        var width: Int
    }
    
    let cells: [Cell]
}
