//
//  ExtendView.swift
//  TestFB
//
//  Created by NHF on 2016/9/28.
//  Copyright © 2016年 NHF. All rights reserved.
//








import UIKit

extension UIView {
    func rotate1To2Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = CGFloat(M_PI)
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}