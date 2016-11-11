//
//  VC_StoreList.swift
//  TestFB
//
//  Created by NHF on 2016/10/18.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class VC_StoreList : VC_BaseVC,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableV_store: UITableView!
    
    var storeList : [String:NSObject]?
    var storeArray : NSArray?
    var nameArray : [AnyObject] = []
    
    //tableView
    override func viewDidLoad() {
        
        storeArray = storeList!["result"] as! NSArray
        for (i) in storeArray! {
            nameArray.append((i as! [String:NSObject])["name"]!)
        }
        
        tableV_store.delegate = self
        tableV_store.dataSource = self
        
        tableV_store.reloadData()
        tableV_store.estimatedRowHeight = 250
        tableV_store.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(nameArray.count)
        return (nameArray.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentify = "StoreCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify, forIndexPath: indexPath) as! TVC_Store
        cell.lbl_name.text = String(nameArray[indexPath.row])
        return cell
    }

}

class TVC_Store :UITableViewCell{
    @IBOutlet var lbl_name : UILabel!
    @IBOutlet var lbl_id : UILabel!
}


