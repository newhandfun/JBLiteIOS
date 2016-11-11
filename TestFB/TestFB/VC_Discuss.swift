//
//  VC_Discuss.swift
//  TestFB
//
//  Created by NHF on 2016/10/10.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class VC_Discuss : VC_BaseVC,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableV_content: UITableView!
    @IBOutlet weak var lbl_storeName: UITextField!
    @IBOutlet weak var lbl_numberOfContent: UITextField!
    @IBOutlet weak var txt_discuss: UITextField!
    @IBOutlet weak var btn_addDiscuss: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var const_buttom: NSLayoutConstraint!
    
    @IBAction func clickAddDiscuss(sender: AnyObject) {
        
        //if inputtext is empty, showError to customer
        if(txt_discuss.text == "")
        {
            showMessage("請輸入評論喔~",buttonText: "我知道了！")
            return
        }
        
        
        //revent custom return on sending message
        btn_back.enabled = false
        
        NSURLSession.sharedSession().dataTaskWithRequest(
        Store.buildDiscussReqest(
            txt_discuss.text!
            )) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                self.showMessage("請檢查網路！若還是發生此情形建議回報此bug。" + String(error), buttonText: "我知道了")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            
            print("res = \(result)")
                
            self.btn_back.enabled = true

            }
            .resume()
    }
    
    override func viewDidAppear(animated: Bool) {
        lbl_storeName.text = Store.name!
        var number : String! = "0"
        number =  String(Store.Discuss!.count)
        lbl_numberOfContent.text = "總共有" + number! + "則評論";
        
    }
    
    func getProfPic(fid: String!) -> UIImage? {
        if (fid != "") {
            let imgURLString = "http://graph.facebook.com/" + fid + "/picture?type=normal"
            let imgURL = NSURL(string: imgURLString)
            if let imageData = NSData(contentsOfURL: imgURL!){
                let image = UIImage(data: imageData)
                return image
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        tableV_content.estimatedRowHeight = 250
        tableV_content.rowHeight = UITableViewAutomaticDimension
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Store.Discuss?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentify = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify, forIndexPath: indexPath) as! TVC_Discuss
        
        cell.lbl_name.text = Store.Discuss![indexPath.row]["nickname"]
        cell.lbl_comment.text = Store.Discuss![indexPath.row]["content"]
        cell.lbl_time.text = Store.Discuss![indexPath.row]["time"]
        
        cell.img_photo.image = getProfPic(Store.Discuss![indexPath.row]["FBid"])
        
        return cell
    }
    
    //textfield
    func textFieldDidBeginEditing(textField: UITextField) {
//        self.view.transform
        print("startEdit")
        UIView.animateWithDuration(0.5, animations: {
            self.const_buttom.constant = 10 + self.view.bounds.height/2 - textField.bounds.height})
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("endEdit")
        UIView.animateWithDuration(1, animations: {
            self.const_buttom.constant = 10})
    }
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        return super.textFieldShouldReturn(textField)
    }
}

class TVC_Discuss :UITableViewCell{
    @IBOutlet var lbl_name : UILabel!
    @IBOutlet var lbl_comment : UILabel!
    @IBOutlet var lbl_time : UILabel!
    @IBOutlet weak var img_photo: UIImageView!
    
    override func layoutSubviews() {
        self.img_photo.layer.cornerRadius = 0.5 * self.img_photo.bounds.width
        img_photo.clipsToBounds = true
    }
}