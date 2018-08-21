//
//  ReserveExtendVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 16..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftDate

class ReserveExtendVC: PresentTestVC {

    let bUseImpossibleTest: Bool = true
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    var arrDetail = [Dictionary<String, Any>]()
    
    let uinfo = UserInfoManager()
    
    var nAddMin: Double = 0.0
    var nAddFee: Double = 0.0
    
    
    var arrImpossible: [String] = []   // For Store ( URL_API_RESERVATION_IMPOSSIBLE )
    var arrArrangeImpossible: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        segControl.layer.cornerRadius = 16
        segControl.layer.borderWidth = 1
        segControl.layer.borderColor = segControl.tintColor.cgColor
        segControl.layer.masksToBounds = true
        
//        segControl.setEnabled(false, forSegmentAt: 0)
        
        
        if false == self.arrDetail.isEmpty {
            if let dicData = self.arrDetail.first as? Dictionary<String, Any> {
                if let strAddMin = dicData["additional_minute"] as? String, let strAddFee = dicData["additional_fees"] as? String {
                    
                    if !strAddMin.isEmpty, !strAddFee.isEmpty {
                        nAddMin = Double(strAddMin)!
                        nAddFee = Double(strAddFee)!
                    }
                    
                }
                
                
                if let company = dicData["company"] as? String {
                    uinfo.rCompany = company
                }

                if let sid = dicData["sid"] as? String {
                    self.requestReservationImpossible(parkinglot_sid: sid, start_time: uinfo.extendStartTime!)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - API ( URL_FETCH_PARKINGLOT_DETAIL )
    func requestFetchParkinglotDetail(sid: String) {
        
        let param = ["sid" : sid] as [String: Any]
        
        Alamofire.request(UrlStrings.URL_FETCH_PARKINGLOT_DETAIL, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_FETCH_PARKINGLOT_DETAIL) : \(String(describing: response.result.error))")
                self.alert("\(UrlStrings.URL_FETCH_PARKINGLOT_DETAIL) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value {
                print("requestFetchParkinglotDetail JSON = \(value)")
                
                self.arrDetail = value as! [Dictionary<String, Any>]
                
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
                
                if self.arrImpossible.count >= 2 {
                    self.arrangeImpossibleTime(arrTime: self.arrImpossible)
                }
            }
        }
    }
    
    
    func arrangeImpossibleTime(arrTime: Array<String>) {
        guard arrTime.isEmpty == false else {
            return
        }
        
        var arrValue: [String] = []
        
        for (index, value) in arrTime.enumerated() {
            print("\(index): \(value)")
            
            if (index % 2 == 0) {
                arrValue = [String]()
                arrValue.append(value)
            } else {
                arrValue.append(value)
                arrArrangeImpossible.append(arrValue)
            }
            
        }
        
        self.calcImpossibleTime(arrTime: arrArrangeImpossible)
    }
    
    
    func calcImpossibleTime(arrTime: [[String]]) {
        
        let exStartDate = uinfo.stringToDate(uinfo.extendStartTime!)
        let exEndDate = exStartDate + 30.minutes
        
        /*
        for item in arrTime {
            
            if let item.first
            
            exEndDate.isBetween(date: <#T##Date#>, and: <#T##Date#>)
        }
        
        
        exEndDate.isBetween(date: <#T##Date#>, and: <#T##Date#>)
 */
    }
    
    
    // MARK: - Btn Action
    
    @IBAction func onBtnCancel(_ sender: UIButton) {
        self.tapMainView(self.view)
    }
    
    @IBAction func onBtnExtend(_ sender: UIButton) {
        
        guard let paymentNavi = self.storyboard?.instantiateViewController(withIdentifier: "PaymentNavi") as? UINavigationController else {
            return;
        }
        
        
        let nMinFee = nAddFee/nAddMin
        var nTotalPay: Double = 0.0
        
        let exStartDate = uinfo.stringToDate(uinfo.extendStartTime!)
        var exEndDate: Date = Date()
        
        switch segControl.selectedSegmentIndex {
        case 0:
            exEndDate = exStartDate + 30.minutes
            nTotalPay = nMinFee * 30
        case 1:
            exEndDate = exStartDate + 1.hours
            nTotalPay = nMinFee * 60
        case 2:
            exEndDate = exStartDate + 2.hours
            nTotalPay = nMinFee * 120
        default:
            exEndDate = exStartDate
            nTotalPay = nMinFee * 30
        }
        
        uinfo.extendEndTime = uinfo.dateToString(exEndDate)
        uinfo.rsvType = "E"
        
        
        uinfo.totalPay = String(format: "%.f", nTotalPay)
        
        
        
        
        self.present(paymentNavi, animated: true, completion: nil)
 
        
        print("\(segControl.selectedSegmentIndex)")
        print(uinfo.extendStartTime!)
        print(uinfo.extendEndTime!)
        
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
