//
//  TutorialMasterVC.swift
//  MyMemory
//
//  Created by MyoungHyoun Cho on 2018. 3. 21..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class TutorialMasterVC: UIViewController, UIPageViewControllerDataSource {

    var pageVC: RaoPageVC!
    
    var contentTitles = ["STEP 0", "STEP 1", "STEP 2","STEP 3","STEP 4"]
    var contentImages = ["Page_0", "Page0", "Page1", "Page2", "Page3"]
    
    @IBOutlet weak var btnLook: UIButton!
    @IBOutlet var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? RaoPageVC
        self.pageVC?.dataSource = self
        
        let startContentVC = self.getContentVC(atIndex: 0)
        self.pageVC?.setViewControllers([startContentVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageVC?.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC?.view.frame.size.width = self.view.frame.width
//        self.pageVC?.view.frame.size.height = self.view.frame.height - 150
        self.pageVC?.view.frame.size.height = self.view.frame.height
        
        self.addChildViewController(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParentViewController: self)
        
        /*
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.white
        pageControl.frame.origin.y = self.view.frame.size.height - 200
 */
        
        self.view.bringSubview(toFront: btnLook)
        self.view.bringSubview(toFront: btnStart)
        
        self.btnLook.isHidden = false
        self.btnStart.isHidden = true
        
    }
    
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in view.subviews {
            if  subView is  UIPageControl {
                subView.frame.origin.y = self.view.frame.size.height - 164
            }
        }
    }
 */

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let pageControl = self.pageVC.RaoPageControl {
            self.btnStart.autoPinEdge(.top, to: .bottom, of: pageControl, withOffset: 20)
            
            self.btnLook.autoPinEdge(.top, to: .bottom, of: pageControl, withOffset: 20)
            
            pageControl.isHidden = true
            self.pageVC.view.isUserInteractionEnabled = false
        }
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Btn Action
    
    
    @IBAction func onBtnLook(_ sender: UIButton) {
        self.btnLook.isHidden = true
        self.btnStart.isHidden = false
        
        if let pageControl = self.pageVC.RaoPageControl {
            pageControl.isHidden = false
            self.pageVC.view.isUserInteractionEnabled = true
            
            contentTitles = ["STEP 1", "STEP 2","STEP 3","STEP 4"]
            contentImages = ["Page0", "Page1", "Page2", "Page3"]
            
            let startContentVC = self.getContentVC(atIndex: 0)
            self.pageVC?.setViewControllers([startContentVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
            
    }
    
    @IBAction func close(_ sender: Any) {
        
        /*
        if let currentViewController = self.pageVC.viewControllers?[0] {
            if let nextPage = self.pageVC.dataSource?.pageViewController(self.pageVC, viewControllerAfter: currentViewController){
                self.pageVC.setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
            }
        }
        */
        
        
        /*
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        */
        
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0;
        }) { (_) in
            self.presentingViewController?.dismiss(animated: false, completion: nil)
        }
        
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
