//
//  DetailVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 4. 26..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class DetailVC: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet var ContentsView: UIView!
    @IBOutlet var lbl_Test: UILabel!
    @IBOutlet var btnExit: UIButton!
    
    @IBOutlet var btnSensor: RoundButton!
    @IBOutlet var btnCCTV: RoundButton!
    
    
    var distance: CLLocationDistance = 0
    @IBOutlet var btnDistance: UIButton!
    
    //    var pageVC: UIPageViewController!
    var pageVC: RaoPageVC!
    
    var contentTitles = ["STEP 1", "STEP 2","STEP 3","STEP 4"]
//    var contentImages = ["Page0", "Page1", "Page2", "Page3"]
    var contentImages: Array<String> = Array()
    
    var dicPlace: Dictionary<String, Any>?
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var graphView: UIView!
    @IBOutlet var conHeightGraphView: NSLayoutConstraint!
    
    
    @IBOutlet var payInfoView: UIView!
    @IBOutlet var conHeightPayInfoView: NSLayoutConstraint!
    @IBOutlet var publicPayInfoView: UIView!
    @IBOutlet var conHeightPublicPayInfoView: NSLayoutConstraint!
    
    @IBOutlet var viewPay: UIView!
    
    
    
    @IBOutlet var btnStartTime: UIButton!
    @IBOutlet var btnEndTime: UIButton!
    
    

    
    @IBOutlet var lblCompany: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblAvailable: UILabel!
    
    
    @IBOutlet var lbl_default_minute: [UILabel]!
//    @IBOutlet var lbl_default_minute: UILabel!
    @IBOutlet var lbl_default_fees: [UILabel]!
//    @IBOutlet var lbl_default_fees: UILabel!
    @IBOutlet var lbl_daily_fees: [UILabel]!
//    @IBOutlet var lbl_daily_fees: UILabel!
    
    @IBOutlet var lbl_additinal: UILabel!
    
    
    @IBOutlet var lbl_TotalTime: UILabel!
    @IBOutlet var lbl_TotalPay: UILabel!
    
    
    let uinfo = UserInfoManager()
    
    var arrImpossible: [String] = []   // For Store ( URL_API_RESERVATION_IMPOSSIBLE )
    
    
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
         
            
            
            if let partner : NSString = dataPlace["partner"] as? NSString, partner.isEqual(to: "0") {
                self.graphView.isHidden = true
                self.conHeightGraphView.constant = 0
                
                self.payInfoView.isHidden = true
                self.conHeightPayInfoView.constant = 0
            } else {
                self.publicPayInfoView.isHidden = true
                self.conHeightPublicPayInfoView.constant = 0
            }
            
            if let strMin = dataPlace["default_minute"] as? String {
//                self.lbl_default_minute.text = "\(strMin)분"
                for label in lbl_default_minute {
                    label.text = "\(strMin)분"
                }
                
            }
            
            if let strFee = dataPlace["default_fees"] as? String {
//                self.lbl_default_fees.text = "\(strFee)원"
                for label in lbl_default_fees {
                    label.text = "\(strFee)원"
                }
            }
            
            if let strDailyFee = dataPlace["daily_fees"] as? String {
//                self.lbl_daily_fees.text = "\(strDailyFee)원"
                for label in lbl_daily_fees {
                    label.text = "\(strDailyFee)원"
                }
            }
            
            if let strAddMin = dataPlace["additional_minute"] as? String, let strAddFee = dataPlace["additional_fees"] as? String {
                self.lbl_additinal.text = "\(strAddMin)분 \(strAddFee)원"
            }
        }
        
        
//        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
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
        
        let strDistance: String
        if distance > 1000 {
            strDistance = String(format: "%.2fkm", distance/1000)
        } else {
            strDistance = String(format: "%.0fm", distance)
        }
        
        
        
        
        
//        let strDistance = String(format: "%.2f", distance)
        
        btnDistance.setTitle(strDistance, for: UIControlState.normal)
        
        ContentsView.autoPinEdge(.top, to: .bottom, of: (self.pageVC?.view)!)
        
        
        requestReservationImpossible(parkinglot_sid: "936", start_time: "test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        lbl_Test.text = dicPlace?.description     // Test
        
        self.navigationController?.navigationBar.isHidden = false
        
        
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
                
                self.viewPay.isHidden = true
            }
            
            if let available : NSString = dataPlace["available"] as? NSString {
                lblAvailable.text = String(format: "%@대", available)
            }
            
            if let company: NSString = dataPlace["company"] as? NSString {
                lblCompany.text = String(format: "%@", company)
            }
            
            if let address: NSString = dataPlace["address"] as? NSString {
                lblAddress.text = String(format: "%@", address)
            }
        }
        
        
        let startDate = uinfo.stringToDate(uinfo.startTime!)
        let endDate = uinfo.stringToDate(uinfo.endTime!)
        
        let strStart = String(format: "입차시간    %d.%02d.%02d %@ %d:%d", startDate.year, startDate.month, startDate.day, startDate.weekdayName, startDate.hour, startDate.minute)
        let strEnd = String(format: "출차시간    %d.%02d.%02d %@ %d:%d", endDate.year, endDate.month, endDate.day, endDate.weekdayName, endDate.hour, endDate.minute)
        
        
        btnStartTime.setTitle(strStart, for: UIControlState.normal)
        btnEndTime.setTitle(strEnd, for: UIControlState.normal)
        
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
    
    // MARK: - API ( URL_API_RESERVATION_IMPOSSIBLE )
    func requestReservationImpossible(parkinglot_sid: String, start_time: String) {
        let param = ["parkinglot_sid" : parkinglot_sid,
            "start_time" : "2018-05-14 10:50:00",
            "offset" : "600"] as [String: Any]
        
        Alamofire.request(UrlStrings.URL_API_RESERVATION_IMPOSSIBLE, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_API_RESERVATION_IMPOSSIBLE) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value as? String {
                self.arrImpossible = value.components(separatedBy: "/")
            }
        }
    }
    
    
    
    // MARK: - Button Action
    
    @IBAction func onBtnTimePicker(_ sender: UIButton) {
        
        guard let timePickerNavi = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerNavi") as? UINavigationController else {
            return
        }
        
        //        let timePickerVC = timePickerNavi.topViewController as? TimePickerVC
        
        if let vc = timePickerNavi.topViewController as? TimePickerVC {
            vc.arrImpossibleTime = self.arrImpossible
        }
        
        self.present(timePickerNavi, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onExit(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func onBtnNavi(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentTestVC") else {
            return
        }
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
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
    
    @IBAction func onBtnPay(_ sender: UIButton) {
        
        let uSession = UserSession()                
        
        if uSession.isLogin == true {
            
        } else {
            
            if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                self.navigationController?.pushViewController(loginVC, animated: true)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
