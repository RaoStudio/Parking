//
//  ReserveDetailVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 13..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire

class ReserveDetailVC: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var btnNavi: RoundButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var resSid: String = ""
    
    // PageVC
    var pageVC: RaoPageVC!
    var contentTitles = ["STEP 1", "STEP 2","STEP 3","STEP 4"]
    var contentImages: Array<String> = Array()
    //
    
    var arrData = [Dictionary<String, Any>]()
    
    
    var strName: String = ""
    var strStatus: String = ""
    var strAddress: String = ""
    var strTime: String = ""
    var strPrice: String = ""
    
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "예약 상세보기"
        
        
        requestFetchReservationDetail(sid: self.resSid)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lbl_Name.text = strName
        lbl_Status.text = strStatus
        lbl_Address.text = strAddress
        lbl_Time.text = strTime
        lbl_Price.text = strPrice
        
        
        if strStatus == "완료" {
            lbl_Status.textColor = hexStringToUIColor(hex: "#888888")
        } else if strStatus == "예약" {
            lbl_Status.textColor = hexStringToUIColor(hex: "#13b6f7")
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        if false == self.arrData.isEmpty {
            
            if let dicData = self.arrData.first, contentImages.isEmpty {
                
                for i in 1...5
                {
                    let str = "img"+String(i)
                    if let img: String = dicData[str] as? String, false == img.isEmpty {
                        contentImages.append(UrlStrings.URL_API_PARKINGLOT_IMG + (img as String))
                    }
                }
                
                if contentImages.isEmpty {
                    contentImages.append("Detail_NoImage")
                }
                
                self.pageVC = self.instanceTutorialVC(name: "PageVC") as? RaoPageVC
                self.pageVC?.dataSource = self
                
                let startContentVC = self.getContentVC(atIndex: 0)
                self.pageVC?.setViewControllers([startContentVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
                
                self.pageVC?.view.frame.origin = CGPoint(x: 0, y: 0)
                self.pageVC?.view.frame.size.width = self.view.frame.width
                //        self.pageVC?.view.frame.size.height = 180
                self.pageVC?.view.frame.size.height = self.view.frame.width * (180/375)
                
                if let naviBar = self.navigationController?.navigationBar {
                    self.pageVC?.view.frame.size.height += 37
                    
                    if #available(iOS 11.0, *) {
                        if RaoIPhoneX.isIPhoneX {
                            self.pageVC?.view.frame.size.height += 24
                        }
                    }
                    
                }
                
                self.addChildViewController(self.pageVC)
                self.view.addSubview(self.pageVC.view)
                self.pageVC.didMove(toParentViewController: self)
                
                
                self.view.bringSubview(toFront: self.btnNavi)
                
                
                scrollView.autoPinEdge(.top, to: .bottom, of: (self.pageVC?.view)!)
                
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - API ( URL_API_RESERVATION_FETCH_DETAIL )
    func requestFetchReservationDetail(sid: String) {
        
        let param = ["sid" : sid] as [String: Any]
        
        Alamofire.request(UrlStrings.URL_API_RESERVATION_FETCH_DETAIL, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_API_RESERVATION_FETCH_DETAIL) : \(String(describing: response.result.error))")
                self.alert("\(UrlStrings.URL_API_RESERVATION_FETCH_DETAIL) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value {
                print("requestFetchReservationDetail JSON = \(value)")
                
                self.arrData = value as! [Dictionary<String, Any>]
                
                self.viewWillLayoutSubviews()
            }
        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
