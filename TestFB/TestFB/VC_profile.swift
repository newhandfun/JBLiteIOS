//
//  VC_profile.swift
//  TestFB
//
//  Created by NHF on 2016/9/14.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class VC_Profile : VC_BaseVC{
    
    
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var text_name: UITextField!
    
    @IBOutlet weak var img_men: UIImageView!
    @IBOutlet weak var img_women: UIImageView!
    
    override func viewDidLoad() {
        text_email.text = StaticUserData.email;
        if(StaticUserData.photo != UIImage()){
            img_profile.image = StaticUserData.photo
        }
        text_name.text = StaticUserData.name;
        
        img_women.hidden = true
        img_men.hidden = true
        
        if StaticUserData.gender == "female"
        {img_women.hidden = false}
        else{img_men.hidden = false}
    }
    
    override func viewDidAppear(animated: Bool) {
        img_profile.layer.cornerRadius = 0.5 * img_profile.bounds.width
        img_profile.clipsToBounds = true
    }
}