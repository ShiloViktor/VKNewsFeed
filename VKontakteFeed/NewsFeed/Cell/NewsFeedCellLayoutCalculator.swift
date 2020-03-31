//
//  NewsFeedCellLayoutCalculator.swift
//  VKontakteFeed
//
//  Created by Виктор on 26.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(photoAttachment: FeedCellPhotoViewModel?, postText: String?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var postAttachmentoFrame: CGRect
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
}

final class NewsFeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(photoAttachment: FeedCellPhotoViewModel?, postText: String?) -> FeedCellSizes {
        
        var moreTextButtonIsShow = false
        
        let cardWidth = screenWidth - Constants.cardViewInsets.left - Constants.cardViewInsets.right
        
        //MARK: PostLabelFrame
        
        var postLabelFrame =  CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHright = Constants.postLabelFont.lineHeight * Constants.minPostLimitLines
            
            if height > limitHright {
                height = Constants.postLabelFont.lineHeight * Constants.minPostLines
                moreTextButtonIsShow = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: moreTex tButtonFrame
        
        var moreTextButtonSize = CGSize.zero

        if moreTextButtonIsShow {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        //MARK: postAttachmentoFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        var postAttachmentoFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachment {
            let photoHeight = Float(attachment.height)
            let photoWidth = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            postAttachmentoFrame.size = CGSize(width: cardWidth, height: cardWidth * ratio)
        }
        
        //MARK: totalHeight
        
        let bottomViewTop = max(postLabelFrame.maxY, postAttachmentoFrame.maxY)

        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardWidth, height: Constants.bottomViewHeight))
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardViewInsets.bottom
        return Sizes(bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     postAttachmentoFrame: postAttachmentoFrame,
                     postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame)
    }
}
