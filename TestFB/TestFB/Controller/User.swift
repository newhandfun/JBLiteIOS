//
//  User.swift
//  TestFB
//
//  Created by NHF on 2016/8/25.
//  Copyright © 2016年 NHF. All rights reserved.
//

import Foundation


public class User : NSDictionary{
    
    //
    var userID : Int = 0
    var exp :Int = 0
    var coin : Int = 0
    var lottery_ticket :Int = 0
    var energy : Int = 0
    
    //
    var name :String! = ""
    var nickname : String! = ""
    var email : String! = ""
    var gender : String! = ""
    var password : String = ""
    
    //FB
    var FBid : Int = 0
    var isFB : Bool = false
    
    public func encodeToJson() -> String?{
        
        let uploadData = self
        var jsonData : NSData!
        
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(uploadData, options: NSJSONWritingOptions())
            
        } catch {
            print(error)
        }
        
        return NSString(data: jsonData,encoding: NSUTF8StringEncoding) as? String
    }
    
 
    
    public func test(){
    }
}