//
//  VC_JoinUs.swift
//  TestFB
//
//  Created by NHF on 2016/10/17.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit


class VC_JoinUs : VC_BaseVC{
    
    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_grade: UITextField!
    @IBOutlet weak var txt_FB: UITextField!
    @IBOutlet weak var txt_hopeTask: UITextField!
    @IBOutlet weak var txtView_whyJoinUs: UITextView!
    
    @IBAction func clickJoinUs(sender: AnyObject) {
        if(txt_name.text == nil ||
            txtView_whyJoinUs.text == nil ||
            txt_hopeTask == nil ||
            txt_FB == nil
            ){
            showMessage("請填好填滿！", buttonText: "知道啦")
            return;
        }
        
        var str = StaticUserData.addParam("", key: "name", value: txt_name.text!)
        str = StaticUserData.addParam(str, key: "fb", value: txt_FB.text!)
        str = StaticUserData.addParam(str, key: "expect", value: txt_hopeTask.text!)
        str = StaticUserData.addParam(str, key: "reason", value: txtView_whyJoinUs.text!)
        builddataTaskWithRequest(buildJBRequest(str, urlAfterJB: "Message/join_us.php", log: "JoinUS"), requestType: "加入我們", doAfterAll: {
            print("完成！")
        }())
    }
    
    var lastWord = ""
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"&&lastWord == "\n"){
        txtView_whyJoinUs.endEditing(true)
            return false
        }
        lastWord = text
        return true
    }
    
    //edit text
    @IBOutlet weak var const_imageUp: NSLayoutConstraint!
    @IBOutlet weak var view_anchor1: UIView!
    func textFieldDidBeginEditing(textField: UITextField) {
        startEdition()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        endEdition()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        startEdition()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        endEdition()
    }
    
    func startEdition(){
        print("startEdit")
        UIView.animateWithDuration(0.5, animations: {
            self.const_imageUp.constant = -self.view_anchor1.bounds.height})
    }
    
    func endEdition(){
        print("endEdit")
        UIView.animateWithDuration(1, animations: {
            self.const_imageUp.constant = -50})
    }
}