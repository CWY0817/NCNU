//
//  PostService.swift
//  plants
//
//  Created by viplab on 2019/3/31.
//  Copyright © 2019年 viplab. All rights reserved.
//

import Foundation
import Firebase

final class PostService {
    
    static let shared: PostService = PostService()
    private init() { }
    
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    let POST_DB_REF: DatabaseReference = Database.database().reference().child("posts")
    let PHOTO_STORAGE_REF: StorageReference = Storage.storage().reference().child("photos")
    
    
    func uploadImage(image: UIImage, completionHandler: @escaping () -> Void) {
        let postDatabaseRef = POST_DB_REF.childByAutoId()
        
        let imageStorageRef = PHOTO_STORAGE_REF.child("\(postDatabaseRef.key).jpg")
        
        let scaledImage = image.scale(newWidth: 640.0)
        
        guard let imageData = UIImageJPEGRepresentation(scaledImage, 0.9) else {
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let uploadTask = imageStorageRef.putData(imageData, metadata:metadata)
        
        uploadTask.observe(.success) { (snapshot) in
            guard let displayName = Auth.auth().currentUser?.displayName else {
                return
            }
            
            imageStorageRef.downloadURL(completion:{ (url,error) in
                if let imageFileURL = url?.absoluteString {
                    let timestamp = Int(NSDate().timeIntervalSince1970 * 1000)
                    
                    let post: [String: Any] = [Post.PostInfoKey.imageFileURL: imageFileURL,
                                               Post.PostInfoKey.user: displayName,
                                               Post.PostInfoKey.timestamp: timestamp]
                    
                    postDatabaseRef.setValue(post)
                }
            })
            completionHandler()
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)/Double(snapshot.progress!.totalUnitCount)
            print("Uploading... \(percentComplete)% complete")
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print(error.localizedDescription)
            }
        }
    }
    
    /*func getRecentPosts(start timestamp: Int? = nil, limit: UInt, completionHandler: @escaping ([Post]) -> Void) {
        var postQuery = POST_DB_REF.queryOrdered(byChild: Post.PostInfoKey.timestamp)
        if let la
    }*/
}
