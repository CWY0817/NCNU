//
//  Post.swift
//  plants
//
//  Created by viplab on 2019/3/31.
//  Copyright © 2019年 viplab. All rights reserved.
//

import Foundation

struct Post {
    
    var postId: String
    var imageFileURL: String
    var user: String
    var votes: Int
    var timestamp: Int
    
    
    enum PostInfoKey {
        static let imageFileURL = "imageFileURL"
        static let user = "user"
        static let votes = "votes"
        static let timestamp = "timestamp"
    }
    
    
    init(postId: String, imageFileURL: String, user: String, votes: Int, timestamp: Int = Int(NSDate().timeIntervalSince1970 * 1000)) {
        self.postId = postId
        self.imageFileURL = imageFileURL
        self.user = user
        self.votes = votes
        self.timestamp = timestamp
    }
    
    init?(postId: String, postInfo: [String: Any]) {
        guard let imageFileURL = postInfo[PostInfoKey.imageFileURL] as? String,
        let user = postInfo[PostInfoKey.user] as? String,
        let votes = postInfo[PostInfoKey.votes] as? Int,
            let timestamp = postInfo[PostInfoKey.timestamp] as? Int else {
                return nil
        }
        self = Post(postId: postId, imageFileURL: imageFileURL, user: user, votes: votes, timestamp: timestamp)
    }
}