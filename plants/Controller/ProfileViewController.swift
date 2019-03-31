//
//  ProfileViewController.swift
//  plants
//
//  Created by viplab on 2019/3/18.
//  Copyright © 2019年 viplab. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController {
    @IBOutlet var nameLabel:UILabel!
    
    @IBAction func logout(sender:UIButton){
        do{
            if let proviserData = Auth.auth().currentUser?.providerData{
                let userInfo = proviserData[0]
                
                switch userInfo.providerID{
                    
                case "google.com":
                    GIDSignIn.sharedInstance()?.signOut()
                    
                default:
                    break
                }
            }

            try Auth.auth().signOut()
        }
        catch{
            let alertController = UIAlertController(title: "Logout Error",message:error.localizedDescription,preferredStyle:.alert)
            let okayAction = UIAlertAction(title:"OK",style:.cancel,handler:nil)
            alertController.addAction(okayAction)
            present(alertController,animated: true,completion: nil)
            return
        }
        //呈現歡迎視圖
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeNav"){
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="My Profile"
        if let currentUser = Auth.auth().currentUser{
            nameLabel.text = currentUser.displayName
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
