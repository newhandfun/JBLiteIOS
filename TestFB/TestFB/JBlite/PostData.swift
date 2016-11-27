//
//  PostData.swift
//  TestFB
//
//  Created by NHF on 2016/8/2.
//  Copyright © 2016年 NHF. All rights reserved.
//

import Foundation

public class PostData  {
    
    var param : String = ""
    var failString : NSString = "{\"success\":\"False\"}"
    var responseString : NSString = NSString()
    
    
    public func LoginFBInBackground(function : ()){
        self.responseString = doInBackGround(haveFBaccount(), funcAfterAll: {
            if self.responseString == self.failString{
                print("沒帳號")
                self.responseString = self.doInBackGround(self.addFBUser(), funcAfterAll: self.LoginFBInBackground(function), finishStr: "註冊")
            }else{
                print("有帳號")
                self.responseString = self.doInBackGround(self.loadUser(), funcAfterAll: function, finishStr: "登入成功")
            }
            
            }(), finishStr: "")
    }
    
    func doInBackGround(request:NSMutableURLRequest,funcAfterAll:(),finishStr:String)->NSString{
        var result : NSString = NSString()
        NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            
            //try to decode
            
            if(StaticUserData.userID == nil){
                StaticUserData.decodeJsonToUserData(result)
            }
            
            if(finishStr == "下載店家資訊"){
                
            }
            print("res = \(result)")
            //  running closure
            print(finishStr)
            funcAfterAll
            }
            .resume()
        return result
    }
    
    func addFBUser()->NSMutableURLRequest{
        let request = NSMutableURLRequest(URL: NSURL(string: "http://140.122.184.227/~ivan/JB/login/addFBUser.php")!)
        request.HTTPMethod = "POST"
        param = ""
        addParam("hash", value: "This is Ivan Speaking.")
        addParam("name", value: StaticUserData.name)
        addParam("gender", value: StaticUserData.gender)
        addParam("nickname", value: StaticUserData.name)
        addParam("email", value: StaticUserData.email)
        addParam("FBid", value: StaticUserData.fbid)
                request.HTTPBody = self.param.dataUsingEncoding(NSUTF8StringEncoding)
        return request
    }
    
    func loadUser()->NSMutableURLRequest{
        let request = NSMutableURLRequest(URL: NSURL(string: "http://140.122.184.227/~ivan/JB/login/loadUser.php")!)
        request.HTTPMethod = "POST"
        param = ""
        addParam("hash", value: "This is Ivan Speaking.")
        addParam("email", value: StaticUserData.email)
                request.HTTPBody = self.param.dataUsingEncoding(NSUTF8StringEncoding)
        return request
    }
    
    func haveFBaccount()->NSMutableURLRequest{
        let request = NSMutableURLRequest(URL: NSURL(string: "http://140.122.184.227/~ivan/JB/login/haveFBaccount.php")!)
        request.HTTPMethod = "POST"
        param = ""
        addParam("hash", value: "This is Ivan Speaking.")
        addParam("email", value: StaticUserData.email)
        addParam("FBid", value: StaticUserData.fbid)
                request.HTTPBody = self.param.dataUsingEncoding(NSUTF8StringEncoding)
        return request
    }
    
    
    func addParam(key:String,value:String){
        let str = String(UTF8String: value.cStringUsingEncoding(NSUTF8StringEncoding)!)
        if param != ""{
            param += "&"
        }
        param += (key + "=" + str!)

    }
    
    func addParam(key:String,value:Int){
        var str = String(value)
        str = String(UTF8String: str.cStringUsingEncoding(NSUTF8StringEncoding)!)!
        if param != ""{
            param += "&"
        }
        param += (key + "=" + str)
    }
    
}
