//
//  VC_Comment.swift
//  TestFB
//
//  Created by NHF on 2016/8/10.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class VC_Comment: VC_BaseVC,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var v_base: UIView!
    @IBOutlet weak var pickView_kind: UIPickerView!
    @IBOutlet weak var btn_kindOfComment: UIButton!
    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var txtView_content: UITextView!
    @IBOutlet weak var btn_type: UIButton!
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        txtView_content.endEditing(true)
    }
    
    //pickview
    var causeKind : [String] = ["針對介面","針對現有功能(不足,多餘或是任何想法)","期待功能","Bug回報","改善建議"]
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return causeKind.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var view_cause: UIView!
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return causeKind[row]
    }
    
    @IBAction func clickSelectionKind(sender: AnyObject) {
        btn_kindOfComment.setTitle(causeKind[pickView_kind.selectedRowInComponent(0)] as String, forState: UIControlState.Normal)
        view_cause.hidden = true
    }
    @IBAction func clickChangeKind(sender: AnyObject) {
        view_cause.hidden = false
    }
    
    @IBAction func clickSend(sender: AnyObject) {
        CallActivityIndicator("建議傳送中")
        var str = StaticUserData.addParam("", key: "userID", value: StaticUserData.userID!)
        str = StaticUserData.addParam(str, key: "context", value: (btn_type.titleLabel?.text!)! + ":" + txtView_content.text!)
        builddataTaskWithRequest(buildJBRequest(str, urlAfterJB: "Message/addMessage.php", log: "意見回報！"), requestType: "意見回報", doAfterAll: {
            performSegueWithIdentifier("Main", sender: self)
            CencleActivityIndicator()
            }())
    }
    
    override func loadView() {
        super.loadView()
    }
    
    var lastword : String! = ""
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            if(lastword == "\n"){
            txtView_content.endEditing(true)
            return false
            }
        }
        lastword = text
        return true
    }
}
