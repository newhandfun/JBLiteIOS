//
//  ViewController.swift
//  TestFB
//
//  Created by NHF on 2016/7/31.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,FBSDKLoginButtonDelegate{

    let loggingButton : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
        }()
    
    override func viewDidLoad() {
       super.viewDidLoad()
//              
//        view.addSubview(loggingButton)
//        loggingButton.center = view.center
//        loggingButton.delegate = self
        
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Loggin")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

