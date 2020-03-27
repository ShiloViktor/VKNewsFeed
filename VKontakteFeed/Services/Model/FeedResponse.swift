//
//  FeedResponse.swift
//  VKontakteFeed
//
//  Created by Виктор on 25.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItems]
    var profiles: [Profile]
    var groups: [Group]
}

struct FeedItems: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let likes: Countable?
    let comments: Countable?
    let reposts: Countable?
    let views: Countable?
    let attachments: [Attachment]?
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return getSize().height
    }
    var width: Int {
        return getSize().width
    }
    var srcBIG: String {
        return getSize().url
    }
    
    private func getSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "Wrong type", url: "Wrong Url", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct Countable: Decodable {
    let count: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }

}

struct Profile: Decodable, ProfileRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String {
        return firstName + " " + lastName
    }
    var photo: String {
        return photo100
    }
}

struct Group: Decodable, ProfileRepresentable {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String {
        return photo100
    }
}
