//
//  PVC_tutorial.swift
//  TestFB
//
//  Created by NHF on 2016/8/10.
//  Copyright © 2016年 NHF. All rights reserved.
//

import UIKit

class PVC_tutorial: UIPageViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1: UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("tuto_1")
        let page2: UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("tuto_2")
        let page3:UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("tuto_3")
        let page4:UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("tuto_4")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
