//
//  Post.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 5/12/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

struct Profile {
    
    // MARK: - Properties
    var user: String
    var imageFileURL: String
    var useremail: String
    var profilephotokey:String
    
    // MARK: - Firebase Keys
    
    enum ProfileInfoKey {
        static let imageFileURL = "imageFileURL"
        static let useremail = "useremail"
        static let profilephotokey = "profilephotokey"
    }
    
    // MARK: - Initialization
    
    init(user: String,imageFileURL: String, useremail: String ,profilephotokey: String) {
        self.imageFileURL = imageFileURL
        self.user = user
        self.useremail = useremail
        self.profilephotokey = profilephotokey
    }
    
    init?(user: String, postInfo: [String: Any]) {
        guard let imageFileURL = postInfo[ProfileInfoKey.imageFileURL] as? String,
            let useremail = postInfo[ProfileInfoKey.useremail] as? String,
            let profilephotokey = postInfo[ProfileInfoKey.profilephotokey] as? String else {
                return nil
        }
        
        self = Profile(user: user, imageFileURL: imageFileURL, useremail: useremail,profilephotokey: profilephotokey)
    }
}
