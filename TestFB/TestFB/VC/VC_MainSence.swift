//
//  VC_MainSence.swift
//  TestFB
//
//  Created by NHF on 2016/8/6.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class VC_MainSence: VC_HasExtraMenu,UICollectionViewDelegate,UICollectionViewDataSource{
    
    //UserData
    var userData : User = User()
    
    
    //tutorial
    @IBOutlet weak var btn_tutorial: UIButton!
    @IBOutlet weak var view_tutorial: UIView!
    @IBOutlet weak var Cont_tuto: UIView!
    
   
    @IBAction func clickTutorial(sender: AnyObject){
        view_tutorial.hidden = !view_tutorial.hidden
        view_bigMenu.hidden = true
        Cont_tuto.hidden = false
        
    }
    
    
    //menu button
    @IBOutlet weak var btn_menu: UIButton!
    @IBOutlet weak var btn_goalSelection: UIButton!
    @IBOutlet weak var view_bigMenu: UIView!
    @IBOutlet weak var silder_price: UISlider!
    @IBOutlet weak var lbl_price: UILabel!
    //none use
    @IBOutlet weak var seg_goal: UISegmentedControl!
    @IBOutlet weak var CV_goal: UICollectionView!
    var currentPrice : Int = 100
    var currentGoal :Int = 1;
    
    @IBAction func clickMenuButton(sender: AnyObject) {
        btn_menu.hidden = true
        view_tutorial.hidden = false
        Cont_tuto.hidden = true
        view_bigMenu.hidden = false
    }
    
    @IBAction func btn_goalSelection(sender: AnyObject) {
        view_tutorial.hidden = true
        btn_menu.hidden = false
        view_bigMenu.hidden = true
        
        SetFindCondition()
    }
    
    
    @IBOutlet weak var btn_lid: UIButton!
    func SetFindCondition(){
        var angle : CGFloat = -0.5
        for index in 1...5{
            angle *= -1
            LipSwing(NSTimeInterval(index) * NSTimeInterval( 0.3), rotaion: angle)
        }
        LipSwing(2, rotaion: 0)
    }
    
    func LipSwing(time:NSTimeInterval,rotaion : CGFloat){
        
        UIButton.animateWithDuration(time, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations:
            {
                self.btn_lid.transform = CGAffineTransformMakeRotation(rotaion)
            }, completion: nil)
    }
    
    
    @IBAction func changePrice(sender: AnyObject) {
        
        var newPrice =  Int(silder_price.value)
        
        if newPrice > currentPrice {
            newPrice += ( 50 - newPrice%50)
            if newPrice > 200
            {newPrice = 200}
        }else
        if newPrice < currentPrice{
            newPrice = newPrice - newPrice%50
            if newPrice < 0
            {newPrice = 0}
        }
        
        silder_price.value = Float(newPrice)
        
        currentPrice = newPrice
        
        lbl_price.text = String(currentPrice)
    }
    
    //price by collection
    //coll
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    //goal by button
    @IBAction func clickDate(sender: AnyObject) {
        currentGoal = 1
        btn_goalSelection(sender)
    }
    
    @IBAction func clickFull(sender: AnyObject) {
        currentGoal = 3
        btn_goalSelection(sender)
    }
    
    @IBAction func clickMeetUp(sender: AnyObject) {
        currentGoal = 2
        btn_goalSelection(sender)
    }
    
    @IBAction func clickDiscuss(sender: AnyObject) {
        currentGoal = 4
        btn_goalSelection(sender)
    }
    
    @IBAction func clickTogether(sender: AnyObject) {
        currentGoal = 5
        btn_goalSelection(sender)
    }
    
    @IBAction func clickAll(sender: AnyObject) {
        currentGoal = 0
        btn_goalSelection(sender)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Goal", forIndexPath: indexPath) as! CVC_Goal
        switch indexPath {
        case 1:
            cell.img_present.image = UIImage(contentsOfFile: "for_full.png")
            break
        default:
            break
        }
        return cell
    }
    
    //store data
    @IBAction func click_lid(sender: AnyObject) {
        CallActivityIndicator("尋找店家中")
        builddataTaskWithRequest(Store.buildReqest(currentGoal, price: Int(silder_price.value/50)), requestType: "!")
    }
    
    override func doAfterRequest(result: NSString) {
        let json = StaticUserData.decodeJson(result)
        Store.name = json["name"]!
        Store.id = Int(json["id"]! as String)!
        Store.address = json["address"]!
        Store.time = json["b_Hour"]!
        Store.tel = json["tel"]!
        let str = "http://140.122.184.227/~ivan/JB/pic/\(Store.name)/店面_\(Store.name)_1.jpg"
        Store.picImg = nil
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            Store.picUrl = NSURL(string: str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        })
        self.CencleActivityIndicator()
        self.performSegueWithIdentifier("Result", sender: self)
    }
    
    //override method
    override func loadView() {
        super.loadView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

        layout.minimumLineSpacing = 0
        
        layout.itemSize = CGSizeMake(
            CGFloat(CV_goal.bounds.width)/3 - 10,
            CGFloat(CV_goal.bounds.height)/2 - 10)
        CV_goal.backgroundView?.backgroundColor = UIColor(white: 1,alpha: 0)
        CV_goal.collectionViewLayout = layout
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        silder_price.continuous = false
        view_tutorial.layer.zPosition = 2
        
        CV_goal.delegate = self
            CV_goal.dataSource = self
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

}

class CVC_Goal : UICollectionViewCell {
    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var img_present: UIImageView!
}


