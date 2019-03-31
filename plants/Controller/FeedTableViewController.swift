//
//  FeedTableViewController.swift
//  plants
//
//  Created by viplab on 2019/3/26.
//  Copyright © 2019年 viplab. All rights reserved.
//

import UIKit
import ImagePicker

class FeedTableViewController: UITableViewController {
    
    
    @IBAction func openCamera(_ sender: Any){
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
        present(imagePickerController, animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

extension FeedTableViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        guard let image = images.first else {
            dismiss(animated: true, completion: nil)
            
            return
        }
        
        PostService.shared.uploadImage(image:image) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
