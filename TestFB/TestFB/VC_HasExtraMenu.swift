//
//  VC_HasExtraMenu.swift
//  TestFB
//
//  Created by NHF on 2016/8/22.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class VC_HasExtraMenu: VC_BaseVC {
    
    @IBOutlet var cter_extra: UIView!
    @IBOutlet weak var view_extraAnchor: UIView!
    var extraViewDistance : CGFloat = 90
    @IBOutlet weak var consLead_extra: NSLayoutConstraint!
    var isClose :Bool = true
    
    //upon Extra view
    @IBOutlet var upExtraView0: UIView!
    @IBOutlet var upExtraView1: UIView!
    @IBOutlet var upExtraView2: UIView!
    
    //black background
    @IBOutlet weak var view_halfBlack: UIView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view_halfBlack.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
                extraViewDistance = self.cter_extra.bounds.width - self.view_extraAnchor.bounds.width
    }
    
    func closeExtraView(times : NSTimeInterval){
        UIView.animateWithDuration(times, animations: {self.cter_extra.transform = CGAffineTransformMakeTranslation( self.cter_extra.transform.tx - self.extraViewDistance , self.cter_extra.transform.ty)})
        isClose = true
        
        UIView.animateWithDuration(times, animations: {
            self.view_halfBlack.alpha = 0
        })
        
        let z:CGFloat = 2
        if upExtraView0 != nil{
            upExtraView0.layer.zPosition = z
        }
        if upExtraView1 != nil{
             upExtraView1.layer.zPosition = z
        }
        if upExtraView2 != nil{
             upExtraView0.layer.zPosition = z
        }
    }
    
    func openExtraView(times : NSTimeInterval)  {
        UIView.animateWithDuration(times, animations: {self.cter_extra.transform = CGAffineTransformMakeTranslation(self.cter_extra.transform.tx + self.extraViewDistance,self.cter_extra.transform.ty)})
        isClose = false
        
        UIView.animateWithDuration(times, animations: {
            self.view_halfBlack.alpha = 0.5
        })
        
        let z:CGFloat = 0
        if upExtraView0 != nil{
            upExtraView0.layer.zPosition = z
        }
        if upExtraView1 != nil{
            upExtraView1.layer.zPosition = z
        }
        if upExtraView2 != nil{
            upExtraView0.layer.zPosition = z
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? VC_HasExtraMenu{
            vc.isClose = self.isClose;
        }
    }
}
