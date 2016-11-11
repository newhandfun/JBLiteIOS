//
//  StaticFunction.swift
//  TestFB
//
//  Created by NHF on 2016/10/15.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class StaticFunction{
    func showMessage(message:String!,buttonText:String!){
        let quetion = UIAlertController(title: nil, message: message, preferredStyle: .Alert);
        let callaction = UIAlertAction(title: buttonText, style: .Default , handler:nil);
        quetion.addAction(callaction);
//        self.presentViewController(quetion, animated: true, completion: nil);
    }
}
