//
//  UserStruct.swift
//  TestFB
//
//  Created by NHF on 2016/9/15.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

struct StaticUserData {
    //FB parameters
    static let parameters = ["fields": "id, name, first_name, last_name, picture.type(normal),gender, email"]
    
    
    //app property
    static var photo : UIImage = UIImage()
    static var photoLarge : UIImage = UIImage();
    
    //
    static var userID : Int?
    static var exp :Int = 0
    static var coin : Int = 0
    static var lottery_ticket :Int = 0
    static var energy : Int = 0
    
    //
    static var name :String! = ""
    static var nickname : String! = ""
    static var email : String! = ""
    static var gender : String! = ""
   static  var password : String = ""
    
    //FB
    static var FBid : Int!
    static var fbid : String!
    static var isFB : Bool = false
    
    //StoreList
    static var storeList : [String:NSObject]?
    
    static func convertFBResultToProperty(result:AnyObject!,function:()){

    }
    
    static func decodeJsonToUserData(str : NSString!){
        do {
            if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                // With value as Int
                if let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:String] {
                    if json["email"] != nil{
                        StaticUserData.email = json["email"]!
                        StaticUserData.name = json["name"]!
                        StaticUserData.gender = json["gender"]!
                        StaticUserData.nickname = json["nickname"]!
                        StaticUserData.userID = Int((json["id"]! as String))!
                        StaticUserData.fbid = json["FBid"]!
                        print("FB->UserDataSecc")
                    }
                }
            }
        } catch {
            print("FB->UserData" + "\(error)")
            return
        }
    }
    
    static func decodeJson(str:NSString)->[String:String]{
        var json:[String:String] = [String:String]()
        do {
            if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                // With value as Int
                json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:String]
            }
            print(json)
            return json
        } catch {
            print(error)
            print("資料抓不成功")
        }
        return json
    }
    
    static func decodeJsonToStore(str : NSString){
        do{
            if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                storeList = json as?  [String:NSObject]
                let house = storeList!["result"] as! NSArray
                print((house[0] as! [String:NSObject])["name"])
            }
        }catch{
        print(error)
        print("店家名單轉型失敗")
        }
        print("")
    }

    
    static func decodeJsonArray(str : NSString)->[[String:String]]?{
        var json : [[String:String]]
        do{
            if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [[String: String]]
                return json
            }else{
                return nil
            }
        }catch{
            print(error)
            print("陣列抓不成功")
        }
        print("")
        return nil
    }
    
    
    static func addParam(orgin:String,key:String,value:String)->String{
        var new = orgin
        let str = String(UTF8String: value.cStringUsingEncoding(NSUTF8StringEncoding)!)
        if(new != ""){
            new += "&"
        }
        new += (key + "=" + str!)
        return new
    }
    
    static func addParam(orgin:String,key:String,value:Int) -> String{
        var new = orgin
        var str = String(value)
        str = String(UTF8String: str.cStringUsingEncoding(NSUTF8StringEncoding)!)!
        if(new != ""){new += "&"}
        new += (key + "=" + str)
        return new
    }
    
}
