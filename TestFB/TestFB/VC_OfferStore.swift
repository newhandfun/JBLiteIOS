//
//  VC_OfferStore.swift
//  TestFB
//
//  Created by NHF on 2016/10/16.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class VC_OfferStore : VC_BaseVC{
    
    enum InputType : Int{
        case phone
        case time
        case address
        case image
        case name
        case Confirm
    }
    
    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var btn_phone: UIButton!
    var phone : String! = ""
    
    @IBOutlet weak var btn_time: UIButton!
    var time : String! = ""
    
    @IBOutlet weak var btn_address: UIButton!
    var address : String! = ""
    
    @IBOutlet weak var btn_uploadImage: UIButton!
    @IBOutlet weak var img_uploadImage: UIImageView!
    var image : String! = ""
    var isImageEncode : Bool = false
    
    @IBOutlet weak var btn_name: UIButton!
    @IBOutlet weak var txt_name: UITextField!
    var name : String! = ""
    
    @IBOutlet weak var btn_confirm: UIButton!
    
    //lifeCycle
    override func viewDidLoad() {
//        btn_confirm.enabled = false;
        btn_name.enabled = false;
    }
    
    //UI change
    @IBAction func clickUploadImage(sender: AnyObject) {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

        self.presentViewController(ImagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func editName(sender: AnyObject) {
        name = txt_name.text
    }
    
    @IBAction func clickAddress(sender: AnyObject) {
        showInputAction("店家地址", content: "請輸入", placeHolder: "這裏～",type: InputType.address)
    }
    
    @IBAction func clickTime(sender: AnyObject) {
        showInputAction("營業時間", content: "請輸入", placeHolder: "這裏～",type: InputType.time)
    }
    
    @IBAction func clickPhone(sender: AnyObject) {
        showInputAction("店家電話", content: "請輸入", placeHolder: "請輸入純數字！",type: InputType.phone)
    }
    
    @IBAction func clickMenu(sender: AnyObject) {
    }
    
    @IBAction func clickConfirm(sender: AnyObject) {
        showInputAction("確認店家資料", content: "如下列表示", placeHolder: "", type: .Confirm)
    }
    
    //some funciton
    func showInputAction(title : String!,content : String!,placeHolder : String!, type: InputType) {
        var checkString  = ""
        let alert = UIAlertController(title: title, message: content, preferredStyle: .Alert)
        if type != InputType.Confirm{
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.placeholder = placeHolder
                switch(type){
                case InputType.phone:
                    textField.keyboardType = .PhonePad
                    break
                default:
                    break
                }
            })
        }else{
            if name != ""{
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.enabled = false
                    textField.borderStyle = UITextBorderStyle
                        .None
                    textField.text = "店家名稱：" + self.name
                })
            }else{checkString += "店家名稱\n"}
            
            if address != ""{
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.enabled = false
                textField.borderStyle = UITextBorderStyle
                    .None
                textField.text = "店家地址:" + self.address
            })
            }else{checkString += "店家地址\n"}
            
            if(time != ""){
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.enabled = false
                textField.borderStyle = UITextBorderStyle
                    .None
                textField.text = "營業時間:" + self.time
            })
            }else{checkString += "營業時間\n"}
            
            if(phone != ""){
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.enabled = false
                textField.borderStyle = UITextBorderStyle
                    .None
                textField.text = "聯絡電話:" + self.phone
            })
            }else{checkString += "聯絡電話\n"}

//            if self.isImageEncode{
//                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
//                    textField.enabled = false
//                    textField.borderStyle = UITextBorderStyle
//                        .None
//                    textField.text = "有圖片"
//                })
//            }else{checkString += "店家圖片"}
            
            if checkString != ""{
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    textField.enabled = false
                    textField.text = "還缺:" + checkString
                })
            }
        }
        alert.addAction(UIAlertAction(title:"確定",style: .Default  ,handler: {
            (action:UIAlertAction!)->Void in
            let textField = alert.textFields![0] as UITextField
            if textField.text! == ""
            {return}
            switch(type)
            {
            case InputType.name:
                self.name = textField.text!
                self.btn_name.alpha = 1.0
                break
            case InputType.time:
                self.time = textField.text!
                self.btn_time.alpha = 1.0
                break
            case InputType.address:
                self.address = textField.text!
                self.btn_address.alpha = 1.0
                break
            case InputType.image:
                self.btn_uploadImage.alpha = 1.0
                break
            case InputType.phone:
                self.phone = textField.text!
                self.btn_phone.alpha = 1.0
                break
            case InputType.Confirm:
                if checkString == ""
                {self.UpdateNewStore()}
                break
            }
        }))
        alert.addAction(UIAlertAction(title:"取消",style: .Cancel  ,handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func UpdateNewStore(){
        var requestString = StaticUserData.addParam("hash=This is Ivan Speaking.", key: "name", value: name)
        requestString = StaticUserData.addParam(requestString, key: "tel", value: phone)
        requestString = StaticUserData.addParam(requestString, key: "userID", value: StaticUserData.userID!)
        requestString = StaticUserData.addParam(requestString, key: "time", value: time!)
        requestString = StaticUserData.addParam(requestString, key: "address", value: address!)
        print("addShopRequest = " + requestString)
        requestString = StaticUserData.addParam(requestString, key: "img", value: image!)
        let request = NSMutableURLRequest(URL:
            NSURL(string:"http://140.122.184.227/~ivan/JB/addStore/addStore.php")!
        )
        request.HTTPMethod = "POST"
        request.HTTPBody = requestString.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLSession.sharedSession().dataTaskWithRequest(
        request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            
            print("提交店家～ = \(result)")
            
            
            if(result != "{\"success\":\"False\"}"){
                print("送出！")
            }
            }
            .resume()
        
    }
    

}
