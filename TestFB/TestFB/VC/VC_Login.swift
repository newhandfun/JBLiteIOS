//
//  VC_Login.swift
//  TestFB
//
//  Created by NHF on 2016/8/31.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class VC_Login: VC_BaseVC,FBSDKLoginButtonDelegate{
    
    @IBOutlet weak var btn_FBLogin: UIButton!
    var loginTimer = NSTimer()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if FBSDKAccessToken.currentAccessToken() != nil{
            CallActivityIndicator("臉書登入中～請稍候");
            getFBUserData()
//            loginTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("goToMainSence"),userInfo: nil, repeats: true)
        }
    }
    
    //登入
    let postData = PostData()
    var isLogin : Bool  = false

    //UI
    @IBOutlet weak var text_emil: UITextField!
    @IBOutlet weak var text_password: UITextField!
    
    //事件
    @IBAction func click_Login(sender: AnyObject) {

    }
    @IBAction func clickFBLogin(sender: AnyObject) {
        FBLogin()
    }
    //FBLogin
    func FBLogin(){
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logInWithReadPermissions(["email","user_friends","public_profile"],fromViewController: self,  handler:  { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
            if(fbloginresult.grantedPermissions.contains("email") )
                {
                    FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
                    self.getFBUserData()
                }else{
                    print("fail")
                    return
                }
            }
        })
    }
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: StaticUserData.parameters).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    StaticUserData.name = result["name"] as? String
                    StaticUserData.email = result["email"] as? String
                    let fbid = result["id"] as? String
                    StaticUserData.fbid = fbid!
                    StaticUserData.gender = result["gender"]as? String
                    StaticUserData.nickname = StaticUserData.name
                    StaticUserData.isFB = true
                    
                    //picture
                    var pictureUrl = ""
                    
                    if let picture = result["picture"] as? NSDictionary,data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                        pictureUrl = url
                    }
                    let url = NSURL(string: pictureUrl)
                    print(url)
                    NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:
                        { (data, response, error) -> Void in
                            if error != nil {
                                print(error)
                                return
                            }else{
                                let image = UIImage(data: data!)
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    StaticUserData.photo = image!
                                })
                            }
                    }).resume()
                    //player data
                    self.builddataTaskWithRequest(self.postData.haveFBaccount(), requestType: "!")
                }
            })
        }
    }
    
    override func doAfterRequest(result: NSString) {
        StaticUserData.decodeJsonToUserData(result)
        if StaticUserData.userID != nil{
            CencleActivityIndicator()
            self.goToMainSence()
        }
        if result == "{\"success\":\"False\"}"{
            builddataTaskWithRequest(self.postData.addFBUser(),requestType: "add")
        }else if isLogin != true{
            isLogin = true
            builddataTaskWithRequest(self.postData.loadUser(), requestType: "load")
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {}

    
    func goToMainSence(){
        CencleActivityIndicator()
        if(StaticUserData.userID != nil){
            performSegueWithIdentifier("Main", sender: self)
//            loginTimer.invalidate()
        }else{
            showMessage("請檢查網路狀態～", buttonText: "我知道了")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
    }
}
