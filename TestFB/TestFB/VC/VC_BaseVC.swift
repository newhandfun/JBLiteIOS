//
//  VC_BaseVC.swift
//  TestFB
//
//  Created by NHF on 2016/8/25.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class VC_BaseVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,
    UITextFieldDelegate,UITextViewDelegate{
    
    internal var user: User=User()
    
    //等待列
    var strLabel = UILabel()
    var background = UIView()
    var messageFrame = UIView()
    
    //照片
    var img_picture : UIImage?
    var str_picture : String?
    @IBOutlet weak var img_displayPic : UIImageView!
    
    //測試用按鈕
    @IBOutlet weak var btn_chooseImage: UIButton!
    @IBOutlet weak var btn_Test: UIButton!
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? VC_BaseVC{
            vc.user = self.user
            print(user.FBid)
            print(user.email)
        }
    }
    
    //Request
    func buildJBRequest(input : String,urlAfterJB:String!,log:String?) -> NSMutableURLRequest{
        var requestString = "hash=This is Ivan Speaking."
        if input != ""{
            requestString += "&" + input
        }
        let request = NSMutableURLRequest(URL:
            NSURL(string:"http://140.122.184.227/~ivan/JB/"+urlAfterJB)!
        )
        request.HTTPMethod = "POST"
        request.HTTPBody = requestString.dataUsingEncoding(NSUTF8StringEncoding)
        if(log != ""){
            print(log! + requestString)}
        return request
    }
    
    func builddataTaskWithRequest(request : NSMutableURLRequest,requestType : String?){
        NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                self.CencleActivityIndicator()
                self.showMessage("發生某些錯誤！煩請檢查一下網路狀態後再試一次！",buttonText: "確認");
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                self.CencleActivityIndicator()
                self.showMessage("發生某些錯誤！煩請檢查一下網路狀態後再試一次！",buttonText: "確認");
                return
            }
            
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(result)
            if(result != "{\"success\":\"False\"}"){
                self.doAfterRequest(result)
                self.doAterRequest2(result)
            }
            }
            .resume()

    }
    
    func builddataTaskWithRequest(request : NSMutableURLRequest,requestType : String?,doAfterAll :())
    {
        self.builddataTaskWithRequest(request, requestType: requestType)
    }
    
    func doAfterRequest(result : NSString){
    }
    
    func doAterRequest2(result : NSString){
    }
    
    //test
    @IBAction func click_chooseImage(sender: AnyObject) {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(ImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func clickTest(sender: AnyObject) {
        if(str_picture! == ""){
            return
        }
        
        let str = StaticUserData.addParam("", key: "img", value: str_picture!)
        builddataTaskWithRequest(buildJBRequest(str, urlAfterJB: "test/test4img.php", log: ""), requestType: "")
    }
    
    //LoadingSomething
    func CallActivityIndicator(msg : String!){
        background.hidden = false
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        background = UIView(frame : CGRect(x:view.frame.minX,y:view.frame.minY,width: view.frame.width,height: view.frame.height))
        background.backgroundColor = UIColor(white: 0, alpha: 0.5)
        background.layer.zPosition = 99
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 115, y: view.frame.midY - 25 , width: 230, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
        messageFrame.layer.zPosition = 100
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        activityIndicator.layer.zPosition = 101
        background.addSubview(messageFrame)
        messageFrame.addSubview(activityIndicator)
        messageFrame.addSubview(strLabel)
        view.addSubview(background)
    }
    func CencleActivityIndicator(){
        background.hidden = true;
    }
    
    
    func showMessage(message:String!,buttonText:String!){
        let quetion = UIAlertController(title: nil, message: message, preferredStyle: .Alert);
        let callaction = UIAlertAction(title: buttonText, style: .Default , handler:nil);
        quetion.addAction(callaction);
        self.presentViewController(quetion, animated: true, completion: nil);
    }
    
    //eazy to use
    //UI anchor
    func setAnchor(anchorPoint : CGPoint, btn : UIControl){
        var newPoint = CGPointMake(btn.bounds.size.width * anchorPoint.x, btn.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(btn.bounds.size.width * btn.layer.anchorPoint.x, btn.bounds.size.height * btn.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, btn.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, btn.transform)
        
        var position : CGPoint = btn.layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x;
        
        position.y -= oldPoint.y;
        position.y += newPoint.y;
        
        btn.layer.position = position;
        btn.layer.anchorPoint = anchorPoint;
    }
    
    func setAnchor(anchorPoint : CGPoint,view:UIView) {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        
        var position : CGPoint = view.layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x;
        
        position.y -= oldPoint.y;
        position.y += newPoint.y;
        
        view.layer.position = position;
        view.layer.anchorPoint = anchorPoint;
    }
    
    //delegate
    
    override func loadView() {
        super.loadView()
        
    }
    //pickpicturefromfile
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        img_picture = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        //            // do some task
        let imageData : NSData = UIImageJPEGRepresentation(self.img_picture!,0.9)!
//        let imageData : NSData = UIImagePNGRepresentation(self.img_picture!)!
        self.str_picture =
            imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        //            });
        self.img_displayPic.image = img_picture
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
