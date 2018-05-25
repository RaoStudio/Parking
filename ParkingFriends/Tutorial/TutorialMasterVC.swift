//
//  TutorialMasterVC.swift
//  MyMemory
//
//  Created by MyoungHyoun Cho on 2018. 3. 21..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class TutorialMasterVC: UIViewController, UIPageViewControllerDataSource {

    var pageVC: UIPageViewController!
    
    var contentTitles = ["STEP 1", "STEP 2","STEP 3","STEP 4"]
    var contentImages = ["Page0", "Page1", "Page2", "Page3"]
    
    @IBOutlet var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC?.dataSource = self
        
        let startContentVC = self.getContentVC(atIndex: 0)
        self.pageVC?.setViewControllers([startContentVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageVC?.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC?.view.frame.size.width = self.view.frame.width
        self.pageVC?.view.frame.size.height = self.view.frame.height - 150
        
        self.addChildViewController(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParentViewController: self)
        
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.white
        
        self.view.bringSubview(toFront: btnStart)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {

        /*
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        */
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
            return nil
        }
        
        guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        
        cvc.titleText = self.contentTitles[idx]
        cvc.imageFile = self.contentImages[idx]
        cvc.pageIndex = idx
        return cvc
    }
    
    
    // MARK: - UIPageViewControllerDataSource
    
    @available(iOS 5.0, *)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        guard index > 0 else {
            return nil
        }
        
        index -= 1
        return self.getContentVC(atIndex: index)
    }
    
    @available(iOS 5.0, *)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        index += 1
        
        guard index < self.contentTitles.count else {
            return nil
        }
        
        return self.getContentVC(atIndex: index)
    }
    
    @available(iOS 6.0, *)
    func presentationCount(for pageViewController: UIPageViewController) -> Int // The number of items reflected in the page indicator.
    {
        return self.contentTitles.count
    }
    
    @available(iOS 6.0, *)
    func presentationIndex(for pageViewController: UIPageViewController) -> Int // The selected item reflected in the page indicator.
    {
        return 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
