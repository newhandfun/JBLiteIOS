//
//  VC_tutorialPage.swift
//  TestFB
//
//  Created by NHF on 2016/9/6.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class VC_tutorialPage: VC_BaseVC {
    
    @IBOutlet weak var btn_pass: UIButton!
    
    @IBAction func clickPass(sender: AnyObject) {
        if btn_pass != nil{
//            print(self.parentViewController?.parentViewController)
            if let vc = self.parentViewController?.parentViewController as? VC_MainSence {
                vc.clickTutorial(vc.btn_tutorial);
            }
        }
    }
    
}
