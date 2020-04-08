//
//  NewsFeedPresenter.swift
//  VKontakteFeed
//
//  Created by Виктор on 25.03.2020.
//  Copyright (c) 2020 Виктор. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
  weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
       let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MM 'в' HH:mm"
        return dt
    }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    switch response {
    case .presentNewsFeed(let response, let postIds):
        
        let cells = response.items.map { (feedItem) in
            convertFeedItemToFeedViewModel(feedItem: feedItem, profile: response.profiles , group: response.groups, postIds: postIds)
        }
        
        let feedViewModel = FeedViewModel.init(cells: cells)
        
        viewController?.displayData(viewModel: .displayNewsFeed(viewModel: feedViewModel))
        
        
    }
}

    private func convertFeedItemToFeedViewModel(feedItem: FeedItems, profile: [Profile], group: [Group], postIds: [Int]) -> FeedViewModel.Cell {
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = postIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        let profile = self.profile(sourceId: feedItem.sourceId, profiles: profile, groupes: group)
        
        let photo = self.photoAttachment(feedItem: feedItem)
        
        let sizes = cellLayoutCalculator.sizes(photoAttachment: photo, postText: feedItem.text, isFullSizedPost: isFullSized)
        
        return FeedViewModel.Cell(postId: feedItem.postId,
                                  iconUrlImageView: profile.photo,
                                  name: profile.name ,
                                  date: dateTitle,
                                  text: feedItem.text,
                                  likes: String(feedItem.likes?.count ?? 0),
                                  comments: String(feedItem.comments?.count ?? 0),
                                  shares: String(feedItem.reposts?.count ?? 0),
                                  views: String(feedItem.views?.count ?? 0),
                                  postPhoto: photo,
                                  sizes: sizes)
    }
    
    private func photoAttachment(feedItem: FeedItems) -> FeedViewModel.FeedcellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedcellPhotoAttachment(imageUrl: firstPhoto.srcBIG, height: firstPhoto.height, width: firstPhoto.width)
    }
    
    private func profile(sourceId: Int, profiles: [Profile], groupes: [Group]) -> ProfileRepresentable {
        
        let profilesOrGroups: [ProfileRepresentable]
        
        if sourceId >= 0 {
            profilesOrGroups = profiles
        } else {
            profilesOrGroups = groupes
        }
      
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let result = profilesOrGroups.first { (profileRepresentable) -> Bool in
            profileRepresentable.id == normalSourceId
        }
        return result!
    }
}
