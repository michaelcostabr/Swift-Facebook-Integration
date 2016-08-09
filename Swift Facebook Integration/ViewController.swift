//
//  ViewController.swift
//  Swift Facebook Integration
//
//  Created by Michael da Costa Silva on 01/08/16.
//  Copyright © 2016 Michael Costa. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var name: UILabel!
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large), email, user_friends"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if (error != nil) {
                print(error.description)
            } else {
                let strFirstName: String = (result.objectForKey("first_name") as? String)!
                let strLastName: String = (result.objectForKey("last_name") as? String)!
                let strEmail: String = (result.objectForKey("email") as? String)!
                let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
                
                self.name.text = "\(strFirstName) \(strLastName) \n (\(strEmail))"
                
                self.profileImg.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        profileImg.image = nil
        self.name.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self
        
        //loginButton.center = self.view.center
        //self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

