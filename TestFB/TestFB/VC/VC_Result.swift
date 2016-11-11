//
//  VC_Result.swift
//  TestFB
//
//  Created by NHF on 2016/8/22.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit
import MapKit

class VC_Result: VC_HasExtraMenu {
    
    @IBOutlet weak var txt_name : UITextField!
    @IBOutlet weak var img_store: UIImageView!
    @IBOutlet weak var btn_address: UIButton!
    @IBOutlet weak var btn_comment: UIButton!
    @IBOutlet weak var btn_phone: UIButton!
    @IBOutlet weak var btn_time: UIButton!
    @IBOutlet weak var mapKit_map: MKMapView!
    
    let emptyString : String = "新增的用戶沒有提供,十分抱歉"
    
    let UIRotation = CGFloat(M_PI)
    
    var imageTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_name.text = Store.name
        loadImage()
//        imageTimer = NSTimer.scheduledTimerWithTimeInterval(0.3, target : self, selector: Selector("loadImage"),userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        btn_phone.transform = CGAffineTransformMakeRotation(UIRotation)
        btn_time.transform = CGAffineTransformMakeRotation(UIRotation)
        btn_comment.transform = CGAffineTransformMakeRotation(UIRotation)
        btn_address.transform = CGAffineTransformMakeRotation(UIRotation)
        UIButton.animateWithDuration(0.7, animations: {
            self.btn_phone.transform = CGAffineTransformMakeRotation(0)
            self.btn_time.transform = CGAffineTransformMakeRotation(0)
            self.btn_comment.transform = CGAffineTransformMakeRotation(0)
            self.btn_address.transform = CGAffineTransformMakeRotation(0)
        })
    }
    
    func loadImage(){
        
        if Store.picImg == nil{
        NSURLSession.sharedSession().dataTaskWithURL(Store.picUrl!,completionHandler:
                {
                    (data, response, error) -> Void in
                    if error != nil {
                        print(error)
                        return
                    }else{
                        let image = UIImage(data: data!)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if(image != nil){
                            Store.picImg = image!
                            self.img_store.image = Store.picImg
                                self.imageTimer.invalidate()
                            }else{
                                print("沒圖片是要怎麼提供Ｒ")
                                self.imageTimer.invalidate()
                                return
                            }
                        })
                    }
            }).resume()
        }
        else{
            img_store.image = Store.picImg
        }
    }
    
    @IBAction func clickTimes(sender: AnyObject) {
        if(Store.time == "Optional(\(""))"){
            Store.time = emptyString
        }
        showMessage(Store.time, buttonText: "我知道了！")
    }
    
    @IBAction func clickPhone(sender: AnyObject) {
        if(Store.tel == "Optional(\(""))"){
            Store.tel = emptyString
        }
        showMessage(Store.tel, buttonText: "我知道了！")
    }
    
    @IBAction func clickAddress(sender: AnyObject) {
        if(Store.address == "Optional(\(""))"){
            Store.address = emptyString
            return
        }
        performSegueWithIdentifier("Map", sender: self)

//        showMessage(Store.address, buttonText: "我知道了！")
    }
    
    @IBAction func clickComment(sender: AnyObject) {
        goToDiscuss(sender)
    }
    
    func goToDiscuss(sender :AnyObject){
        
        self.CallActivityIndicator("取得評論中～")
        self.builddataTaskWithRequest(Store.buildCommentReqest(), requestType: "")
    }
    
    override func doAfterRequest(result: NSString) {
        //get comment
        Store.Discuss = StaticUserData.decodeJsonArray (result)
        
        if(Store.Discuss != nil){
            self.performSegueWithIdentifier("Discuss", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let map = segue.destinationViewController as? VC_Map{
            map.address = Store.address
        }
    }
    
    
}
