//
//  VC_ExtraOption.swift
//  TestFB
//
//  Created by NHF on 2016/8/21.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit


class VC_ExtraOption: VC_BaseVC {
    
    //component
    @IBOutlet var view_base: UIView!
    @IBOutlet weak var btn_bell: UIButton!
    @IBOutlet weak var view_sign: UIView!
    @IBOutlet weak var btn_photo: UIButton!
    @IBOutlet weak var text_hello: UILabel!
    @IBOutlet weak var btn_search: UIButton!
    
    //get parent VC
    var parent : VC_HasExtraMenu = VC_HasExtraMenu()
    
    internal var extraViewDistance : CGFloat{
        get{
//            return view_base.bounds.width - btn_bell.bounds.width
            return view_sign.bounds.width + 20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() != nil){
            btn_photo.setImage(
                StaticUserData.photo,
                forState: UIControlState.Normal)
            text_hello.text = "你好,"+StaticUserData.name
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        btn_photo.clipsToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        btn_photo.layer.cornerRadius = 0.5*btn_photo.bounds.size.width
        initialSelf()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? VC_StoreList{
            vc.storeList = StaticUserData.storeList
        }
    }
    
    func initialSelf() {
        if let _main = self.parentViewController{
            parent = _main as! VC_HasExtraMenu
        }
        
        setAnchor(CGPointMake(0.5,0), btn: btn_bell)
        setAnchor(CGPointMake(0.5,0), view: view_sign)
        
        if !parent.isClose {
            parent.closeExtraView(0)
        }
        
    }
    
    
    @IBAction func clickBellButton(sender: AnyObject) {
        if !parent.isClose {
            parent.closeExtraView(0.5)
            bellSwing(0.5,rotaion: 1)
            signSwing(0.5,rotaion: 0.1)
            bellSwing(1.2,rotaion: 0)
            signSwing(1,rotaion: 0)
        }
        else{
            parent.openExtraView(0.5)
            bellSwing(0.5,rotaion: -1)
            signSwing(0.5,rotaion: -0.1)
            bellSwing(1.2,rotaion: 0)
            signSwing(1,rotaion: 0)
        }
    }
    @IBAction func clickSearch(sender: AnyObject) {
        parent.CallActivityIndicator("讀取店家資料中")
        builddataTaskWithRequest(buildJBRequest("", urlAfterJB:
            "Store/getAllStore.php", log: "拿取店家資料："), requestType: "店家陣列", doAfterAll: {}()
        )
    }
    
    override func doAfterRequest(result : NSString) {
        StaticUserData.decodeJsonToStore(result)
        parent.CencleActivityIndicator()
        if StaticUserData.storeList != nil {
            performSegueWithIdentifier("Find", sender: self)
        }else{
            showMessage("沒有抓到店家！如果網路有開但不行的話請回報此BUG", buttonText: "我知道了")
        }
    }

    
    func bellSwing(time:NSTimeInterval,rotaion : CGFloat){
        
        UIButton.animateWithDuration(time, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations:
            {
                self.btn_bell.transform = CGAffineTransformMakeRotation(rotaion)
            }, completion: nil)

    }
    
    func signSwing(time:NSTimeInterval,rotaion : CGFloat){
        UIView.animateWithDuration(time, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations:
            {
                self.view_sign.transform = CGAffineTransformMakeRotation(rotaion)
            }, completion: nil)
    }

}
