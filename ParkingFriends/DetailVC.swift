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
import SwiftDate



class DetailVC: UIViewController, UIPageViewControllerDataSource {

    
    let bUseImpossibleTest: Bool = false
    
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
    
    
    @IBOutlet weak var lbl_OperationTime: UILabel!
    @IBOutlet weak var viewTimeGraph: UIView!
    
    var strOperationTime: String = ""
    
    var fDistanceOfOneTime: CGFloat = 0
    var fDistanceOfTenMinute: CGFloat = 0
    var fDistanceOfOneMinute: CGFloat = 0
    
    var fOpStartHour: Float = 0
    var fOpStartMin: Float = 0
    
    var fOpEndHour: Float = 0
    var fOpEndMin: Float = 0
    
    
    let uinfo = UserInfoManager()
    
    var arrImpossible: [String] = []   // For Store ( URL_API_RESERVATION_IMPOSSIBLE )
    
    var strOperationDay: String = ""
    
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblTomorrow: UILabel!
    
    
    @IBOutlet weak var distanceStackView: UIStackView!
    @IBOutlet weak var opTimeView: UIView!
    
    var strSid: String = ""
    var strPay: String = ""
    
    
    var nDefaultMin: Int = 0
    var nDefaultFee: Int = 0
    
    var nAddMin: Int = 0
    var nAddFee: Int = 0
    
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
                    
                    var strImg: String
                    
                    if false == img.contains(UrlStrings.URL_API_PARKINGLOT_IMG) {
                        strImg = UrlStrings.URL_API_PARKINGLOT_IMG + img
                    } else {
                        strImg = img
                    }
                    
                    contentImages.append(strImg)
                    
//                    contentImages.append(UrlStrings.URL_API_PARKINGLOT_IMG + (img as String))
                }
            }
            
            if contentImages.isEmpty {
                contentImages.append("Detail_NoImage")
            }
         
            
            let partner : NSString = dataPlace["partner"] as! NSString
            let nPartner: Int = Int(partner.intValue)
            
            if nPartner == 0 {
//            if let partner : NSString = dataPlace["partner"] as? NSString, partner.isEqual(to: "0") {
                self.graphView.isHidden = true
                self.conHeightGraphView.constant = 0
                
                self.payInfoView.isHidden = true
                self.conHeightPayInfoView.constant = 0
            } else {
                self.publicPayInfoView.isHidden = true
                self.conHeightPublicPayInfoView.constant = 0
            }
            
            
            // Test
            /*
            self.publicPayInfoView.isHidden = true
            self.conHeightPublicPayInfoView.constant = 0
             */
            //
            
            
            
            if let strMin = dataPlace["default_minute"] as? String {
//                self.lbl_default_minute.text = "\(strMin)분"
                for label in lbl_default_minute {
                    label.text = "\(strMin)분"
                }
                
                if !strMin.isEmpty {
                    nDefaultMin = Int(strMin)!
                }
                
            }
            
            if let strFee = dataPlace["default_fees"] as? String {
//                self.lbl_default_fees.text = "\(strFee)원"
                for label in lbl_default_fees {
                    label.text = "\(strFee.decimalPresent)원"
                }
                
                self.strPay = strFee
                
                if !strFee.isEmpty {
                    nDefaultFee = Int(strFee)!
                }
            }
            
            if let strDailyFee = dataPlace["daily_fees"] as? String {
//                self.lbl_daily_fees.text = "\(strDailyFee)원"
                for label in lbl_daily_fees {
                    label.text = "\(strDailyFee.decimalPresent)원"
                }
            } else if let nDailyFee = dataPlace["daily_fees"] as? NSNumber {
                for label in lbl_daily_fees {
                    label.text = "\(nDailyFee.stringValue.decimalPresent)원"
                }
            }
            
            
            if let strAddMin = dataPlace["additional_minute"] as? String, let strAddFee = dataPlace["additional_fees"] as? String {
                self.lbl_additinal.text = "\(strAddMin)분 \(strAddFee)원"
                
                if !strAddMin.isEmpty, !strAddFee.isEmpty {
                    nAddMin = Int(strAddMin)!
                    nAddFee = Int(strAddFee)!
                }
                
            }
            
            
            var strWeek: String = ""
//            let today = Date()
            let today = uinfo.stringToDate(uinfo.startTime!)
            
            print(today.weekdayName)
            
            if today.isInWeekend {
                /*
                let nNum = today.weekday
                if nNum == 1 {
                    strWeek = "operationtime_holiday"
                    strOperationDay = "일요일"
                } else {
                    strWeek = "operationtime_saturday"
                    strOperationDay = "토요일"
                }
                */
                strWeek = "operationtime_holiday"
                strOperationDay = "휴일"
                
            } else {
                strWeek = "operationtime_week"
                strOperationDay = "평일"
            }
            
            
            if let strOperationTime = dataPlace[strWeek] as? String {
                self.lbl_OperationTime.text = strOperationTime
                self.strOperationTime = strOperationTime
            }
            
            
            if let strSID = dataPlace["sid"] as? String {
                self.strSid = strSID
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
        
        
        let sWidth = UIScreen.main.bounds.width - 24
        
        
//        fDistanceOfOneTime = viewTimeGraph.frame.width/24
        fDistanceOfOneTime = sWidth/24
        fDistanceOfTenMinute = fDistanceOfOneTime/6
        fDistanceOfOneMinute = fDistanceOfTenMinute/10
        
        
        // Test ~
        let df = DateFormatter()
        df.locale = Locale.current
        df.timeZone = TimeZone.current
        df.dateFormat = "HHmm"
        if let date = df.date(from: "1900") {
            let str = df.string(from: date)
            print(str)
        }
        // Test ~
        
        
        
        
        
        
//        requestReservationImpossible(parkinglot_sid: "936", start_time: "test")
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
            
            let partner : NSString = dataPlace["partner"] as! NSString
            let nPartner: Int = Int(partner.intValue)
            
            if nPartner == 1 {
            
//            if let partner : NSString = dataPlace["partner"] as? NSString, partner.isEqual(to: "1") {
                self.btnSensor.isHidden = false
                self.view.bringSubview(toFront: self.btnSensor)
               
                if let cctv: NSString = dataPlace["cctv"] as? NSString, cctv.isEqual(to: "0") {
                    self.btnCCTV.isHidden = true
                } else {
                    self.btnCCTV.isHidden = false
                    self.view.bringSubview(toFront: self.btnCCTV)
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
            } else {
                lblCompany.text = ""
            }
            
            if let address: NSString = dataPlace["address"] as? NSString {
                lblAddress.text = String(format: "%@", address)
            }
            
            
            calcOperationTime(strOperation: strOperationTime)
            
            
            self.drawTimeStick()
            
            
            
            let xPos: CGFloat = (fDistanceOfOneTime * CGFloat(fOpStartHour)) + (fDistanceOfOneMinute * CGFloat(fOpStartMin))
            let wGreen: CGFloat = (fDistanceOfOneTime * CGFloat(fOpEndHour-fOpStartHour)) + (fDistanceOfOneMinute * CGFloat(fOpEndMin))
            
            let viewOpGreen = UIView(frame: CGRect(x: xPos, y: 0, width: wGreen, height: 10))
            viewOpGreen.backgroundColor = hexStringToUIColor(hex: "#22d158")
            self.viewTimeGraph.addSubview(viewOpGreen)
            
            
            if wGreen < 0 {
                let view = UIView()
//                view.backgroundColor = self.viewTimeGraph.backgroundColor
                viewOpGreen.backgroundColor = hexStringToUIColor(hex: "#aaaaaa")
                self.viewTimeGraph.backgroundColor = hexStringToUIColor(hex: "#22d158")
            }
            
            if let bAvail = dataPlace["bAvailOpTime"] as? Bool {
                if bAvail == false {
                    self.opTimeView.isHidden = false
                    self.view.bringSubview(toFront: self.opTimeView)
                } else {
                    self.opTimeView.isHidden = true
                }
            } else {
                self.opTimeView.isHidden = true
            }
            
            
        }
        
        
        let startDate = uinfo.stringToDate(uinfo.startTime!)
        let endDate = uinfo.stringToDate(uinfo.endTime!)
        
        let strStart = String(format: "입차시간    %d.%02d.%02d %@ %02d:%02d", startDate.year, startDate.month, startDate.day, startDate.weekdayName, startDate.hour, startDate.minute)
        let strEnd = String(format: "출차시간    %d.%02d.%02d %@ %02d:%02d", endDate.year, endDate.month, endDate.day, endDate.weekdayName, endDate.hour, endDate.minute)
        
        
        btnStartTime.setTitle(strStart, for: UIControlState.normal)
        btnEndTime.setTitle(strEnd, for: UIControlState.normal)
        
        
        self.lblToday.text = String(format: "%02d.%02d", startDate.month, startDate.day)
        self.lblTomorrow.text = String(format: "%02d.%02d", startDate.month, startDate.day+1)
        
        
        
        let nTime = endDate - startDate
        
        let nDisplayHour = Int(nTime) / 3600
        let nDisplayMin = (Int(nTime) % 3600) / 60
        
        
        if nDisplayMin > 0 {
            self.lbl_TotalTime.text = String(format: "%d시간 %d분", nDisplayHour, nDisplayMin)
            strPay = String(format: "%d", (Int(strPay)! * nDisplayHour) + Int(strPay)!)
        } else {
            self.lbl_TotalTime.text = String(format: "%d시간", nDisplayHour)
            strPay = String(format: "%d", Int(strPay)! * nDisplayHour)
        }
        
        
        // Calc Total Pay
        var nTotalPay: Int = nDefaultFee
        let nTotalMin = Int(nTime) / 60
        let nRestMin = nTotalMin - self.nDefaultMin
        
        if nAddMin > 0 {
            let nTimeMultiply = nRestMin / nAddMin
            let nTimeMultiplyRest = nRestMin % nAddMin
            nTotalPay = nTotalPay + nAddFee * nTimeMultiply
            if nTimeMultiplyRest > 0 {
                nTotalPay = nTotalPay + nAddFee
            }
        }
        
        strPay = String(format: "%d", nTotalPay)
        
        self.lbl_TotalPay.text = "\(strPay.decimalPresent) 원"
        
        uinfo.totalPay = strPay
        
        
//        requestReservationImpossible(parkinglot_sid: "936", start_time: "test")
        
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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        /*
        
        fDistanceOfOneTime = viewTimeGraph.frame.width/24
        fDistanceOfTenMinute = fDistanceOfOneTime/6
        fDistanceOfOneMinute = fDistanceOfTenMinute/10
        
        let xPos: CGFloat = (fDistanceOfOneTime * CGFloat(fOpStartHour)) + (fDistanceOfOneMinute * CGFloat(fOpStartMin))
        let wGreen: CGFloat = (fDistanceOfOneTime * CGFloat(fOpEndHour-fOpStartHour)) + (fDistanceOfOneMinute * CGFloat(fOpEndMin))
        
        let viewOpGreen = UIView(frame: CGRect(x: xPos, y: 0, width: wGreen, height: 10))
        viewOpGreen.backgroundColor = hexStringToUIColor(hex: "#22d158")
        self.viewTimeGraph.addSubview(viewOpGreen)
         */
        
//        self.alert("\(viewTimeGraph.frame.width)")
        
        
//        requestReservationImpossible(parkinglot_sid: "936", start_time: uinfo.startTime!)
        
        
        if let dataPlace = self.dicPlace {
            
            let partner : NSString = dataPlace["partner"] as! NSString
            let nPartner: Int = Int(partner.intValue)
            if nPartner == 1 {
                requestReservationImpossible(parkinglot_sid: strSid, start_time: uinfo.startTime!)
            }
            
            
            /*
            if let bAvail = dataPlace["bAvailOpTime"] as? Bool {
                if bAvail == false {
                    let lblAvail = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 10))
                    lblAvail.backgroundColor = UIColor.red
                    lblAvail.text = "예약 가능한 시간이 아닙니다."
             
                    self.view.addSubview(lblAvail)
             
                    lblAvail.autoPinEdge(.top, to: .bottom, of: distanceStackView)
                }
            }
            */
            
            
            
        }
        
        requestGetAvailable(parkinglot_sid: strSid, start_time: uinfo.startTime!, end_time: uinfo.endTime!)
        
    }
    
    func drawTimeStick() {
        for i in 0 ..< 24 {
            
            let xPos: CGFloat = fDistanceOfOneTime * CGFloat(i)
            
            let viewStick = UIView(frame: CGRect(x: xPos, y: 10, width: 1, height: 3))
//            viewStick.backgroundColor = hexStringToUIColor(hex: "#22d158")
            viewStick.backgroundColor = hexStringToUIColor(hex: "#AAAAAA")
            self.viewTimeGraph.addSubview(viewStick)
        }
    }
    
    
    // MARK: - Calc Operation Time
    func calcOperationTime(strOperation: String) {
        var arrStr = strOperation.split(separator: "~").map { String($0)}
        
        
        if arrStr.count < 2 {
            arrStr.removeAll()
            
            arrStr = strOperation.split(separator: "-").map { String($0)}
        }
        
        
        if let strStart = arrStr.first, let strEnd = arrStr.last {
            print(strStart)
            print(strEnd)
            
            
            let arrSTime = strStart.split(separator: ":").map { String($0)}
            let arrETime = strEnd.split(separator: ":").map { String($0)}
            
            if arrSTime.count < 2 && arrETime.count < 2 {
                fOpStartHour = Float(strStart[0..<2])!
                fOpStartMin = Float(strStart[2..<strStart.count])!
                
                fOpEndHour = Float(strEnd[0..<2])!
                fOpEndMin = Float(strEnd[2..<strEnd.count])!
                
            } else {
                
                fOpStartHour = Float(arrSTime.first!)!
                fOpStartMin = Float(arrSTime.last!)!
                
                fOpEndHour = Float(arrETime.first!)!
                fOpEndMin = Float(arrETime.last!)!
            }
            
            /*
            fOpStartHour = Float(strStart[0..<2])!
            fOpStartMin = Float(strStart[2..<strStart.count])!
            
            fOpEndHour = Float(strEnd[0..<2])!
            fOpEndMin = Float(strEnd[2..<strEnd.count])!
 */
            
            if fOpEndHour == 00 {
                fOpEndHour = 24
            }
            
            self.lbl_OperationTime.text = String(format: "%@ %02.0f:%02.0f~%02.0f:%02.0f", strOperationDay,fOpStartHour, fOpStartMin, fOpEndHour, fOpEndMin)
        }
    }
    
    
    func calcImpossibleTime(arrTime: Array<String>) {
        guard arrTime.isEmpty == false else {
            return
        }
        
        
        var arrValidate = [String]()
        
        for (index, item) in arrTime.enumerated() {
            let date = self.uinfo.stringToDate(item)
            if date.isToday == true {
                arrValidate.append(self.uinfo.dateToString(date))
            }
        }
        
        print(arrValidate)
        
        
        var fStartHour: Float = 0
        var fStartMin: Float = 0
        var dateStart: Date!
        
        var fEndHour: Float = 0
        var fEndMin: Float = 0
        var dateEnd: Date!
        
        let uinfo = UserInfoManager()
        
//        for (index, value) in arrImpossible.enumerated() {
        for (index, value) in arrValidate.enumerated() {
            print("\(index) : \(value)")
            
            let arrStr = value.split(separator: " ").map { String($0) }
            
            if let strFirst = arrStr.first, let strEnd = arrStr.last {
//                print(strFirst)
//                print(strEnd)
                
                if (index % 2 == 0) {
                    fStartHour = Float(strEnd[0..<2])!
                    fStartMin = Float(strEnd[3..<5])!
                    dateStart = uinfo.stringToDate(value)
                    
                } else {
                    fEndHour = Float(strEnd[0..<2])!
                    fEndMin = Float(strEnd[3..<5])!
                    dateEnd = uinfo.stringToDate(value)
                    
                    let minInteval = dateEnd.timeIntervalSince(dateStart)/60
                    
                    let xPos: CGFloat = (fDistanceOfOneTime * CGFloat(fStartHour)) + (fDistanceOfOneMinute * CGFloat(fStartMin))
//                    let wRed: CGFloat = (fDistanceOfOneTime * CGFloat(fEndHour-fStartHour)) + (fDistanceOfOneMinute * CGFloat(fEndMin))
                    let wRed: CGFloat = (fDistanceOfOneMinute * CGFloat(minInteval))
                    
                    let viewOpRed = UIView(frame: CGRect(x: xPos, y: 0, width: wRed, height: 10))
                    //                viewOpRed.backgroundColor = hexStringToUIColor(hex: "#22d158")
                    viewOpRed.backgroundColor = UIColor.red
                    self.viewTimeGraph.addSubview(viewOpRed)
                    
                    
                    fStartHour = 0
                    fStartMin = 0
                    
                    fEndHour = 0
                    fEndMin = 0
                    
                    print(" ")
                }
                
            }
        }
        
    }
    
    
    // MARK - API ( URL_API_PARKINGLOT_AVAILABLE )
    func requestGetAvailable(parkinglot_sid: String, start_time: String, end_time: String) {
        self.navigationController?.view.makeToastActivity(.center)
        
        let url = UrlStrings.URL_API_PARKINGLOT_AVAILABLE
        
        let param = ["sid": parkinglot_sid, "begin": start_time, "end": end_time]
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response) in
            
            self.navigationController?.view.hideToastActivity()
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_API_PARKINGLOT_AVAILABLE) : \(String(describing: response.result.error))")
                self.alert("\(UrlStrings.URL_API_PARKINGLOT_AVAILABLE) : \(String(describing: response.result.error))")
                return
            }
            
            
            if let value = response.result.value as? Dictionary<String, Any> {
                print("requestGetAvailable JSON = \(value)")
                
                if let strStatus = value["status"] as? String {
                    if strStatus == "200" {
                        
                    } else {
                        
                    }
                }
            }
            
        }
    }
    
    
    
    // MARK: - API ( URL_API_RESERVATION_IMPOSSIBLE )
    func requestReservationImpossible(parkinglot_sid: String, start_time: String) {
        
        var strStart: String
        
        if bUseImpossibleTest {
            strStart = "2018-05-14 10:50:00"
        } else {
            strStart = start_time
        }
        
        
        let param = ["parkinglot_sid" : parkinglot_sid,
//            "start_time" : "2018-05-14 10:50:00",
            "start_time" : strStart,
            "offset" : "600"] as [String: Any]
        
        Alamofire.request(UrlStrings.URL_API_RESERVATION_IMPOSSIBLE, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_API_RESERVATION_IMPOSSIBLE) : \(String(describing: response.result.error))")
                self.alert("\(UrlStrings.URL_API_RESERVATION_IMPOSSIBLE) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value as? String, false == value.isEmpty {
                self.arrImpossible = value.components(separatedBy: "/")
                
                if self.bUseImpossibleTest {
//                    self.arrImpossible.append("2018-08-28 00:00:00")
//                    self.arrImpossible.append("2018-08-28 01:00:00")
                    self.arrImpossible.append("2018-08-29 12:00:00")
                    self.arrImpossible.append("2018-08-29 13:00:00")
                    self.arrImpossible.append("2018-08-30 15:00:00")
                    self.arrImpossible.append("2018-08-30 16:40:00")
//                    self.arrImpossible.append("2018-08-28 23:00:00")
//                    self.arrImpossible.append("2018-08-29 01:00:00")
//                    self.arrImpossible.append("2018-08-29 15:00:00")
//                    self.arrImpossible.append("2018-08-29 16:00:00")
                }
                
                
                if self.arrImpossible.count >= 2 {
                    self.calcImpossibleTime(arrTime: self.arrImpossible)
                }
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
        /*
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentTestVC") else {
            return
        }
        */
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NaviVC") else {
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
            
            let bOpTimeViewHidden = self.opTimeView.isHidden
            
            if bOpTimeViewHidden == false {
                self.alert("예약가능한 시간이 아닙니다.")
                return
            }
            
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResCheckVC") as? ResCheckVC else {
                return
            }
            
            
            uinfo.lotSid = strSid
            uinfo.rsvType = "R"
            
            vc.bTab = false
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion: nil)
            
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
