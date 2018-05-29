//
//  DetailVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 4. 26..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import CoreLocation

class DetailVC: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet var lbl_Test: UILabel!
    @IBOutlet var btnExit: UIButton!
    
    @IBOutlet var btnSensor: RoundButton!
    @IBOutlet var btnCCTV: RoundButton!
    
    
    var distance: CLLocationDistance = 0
    
//    var pageVC: UIPageViewController!
    var pageVC: RaoPageVC!
    
    var contentTitles = ["STEP 1", "STEP 2","STEP 3","STEP 4"]
//    var contentImages = ["Page0", "Page1", "Page2", "Page3"]
    var contentImages: Array<String> = Array()
    
    var dicPlace: Dictionary<String, Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.navigationItem.title = "주차장 예약"
        
        if let dataPlace = self.dicPlace {
            //            let cctv : NSString = dataPlace["cctv"] as! NSString
            
            for i in 1...5
            {
                let str = "img"+String(i)
                if let img: String = dataPlace[str] as? String, false == img.isEmpty {
                    contentImages.append(UrlStrings.URL_API_PARKINGLOT_IMG + (img as String))
                }
            }
            
            if contentImages.isEmpty {
                contentImages.append("Detail_NoImage")
            }
            
        }
        
        
//        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? RaoPageVC
        self.pageVC?.dataSource = self
        
        let startContentVC = self.getContentVC(atIndex: 0)
        self.pageVC?.setViewControllers([startContentVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageVC?.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC?.view.frame.size.width = self.view.frame.width
        self.pageVC?.view.frame.size.height = 180
        
        if let naviBar = self.navigationController?.navigationBar {
            self.pageVC?.view.frame.size.height += 44
        }
        
        self.addChildViewController(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParentViewController: self)
        
        
        /*
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.white
        */
        
        
        
        /*
        if let path = user["profile_path"] as? String {
            if let imageData = try? Data(contentsOf: URL(string: path)!) {
                self.profile = UIImage(data: imageData)
            }
        }
         */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbl_Test.text = dicPlace?.description
        self.view.bringSubview(toFront: self.btnExit)
        
        if let dataPlace = self.dicPlace {
            if let partner : NSString = dataPlace["partner"] as? NSString, partner.isEqual(to: "1") {
                self.btnSensor.isHidden = false
                self.view.bringSubview(toFront: self.btnSensor)
               
                if let cctv: NSString = dataPlace["cctv"] as? NSString, cctv.isEqual(to: "1") {
                    self.btnCCTV.isHidden = false
                    self.view.bringSubview(toFront: self.btnCCTV)
                } else {
                    self.btnCCTV.isHidden = true
                }
            } else {
                self.btnSensor.isHidden = true
                self.btnCCTV.isHidden = true
            }
        }
        
        /*
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        testView.backgroundColor = UIColor.red
        self.view.addSubview(testView)
        self.view.addConstraintForFullsizeWithSubView(subview: testView)
         */
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
    

    @IBAction func onExit(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        guard self.contentImages.count >= idx && self.contentImages.count > 0 else {
            return nil
        }
        
        guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        
//        cvc.titleText = self.contentTitles[idx]
        cvc.titleText = ""
        cvc.imageFile = self.contentImages[idx]
//        cvc.imageFile = self.arrContentImages[idx]
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
        
        guard index < self.contentImages.count else {
            return nil
        }
        
        return self.getContentVC(atIndex: index)
    }
    
    @available(iOS 6.0, *)
    func presentationCount(for pageViewController: UIPageViewController) -> Int // The number of items reflected in the page indicator.
    {
        return self.contentImages.count
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
