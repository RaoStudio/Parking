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

    @IBOutlet weak var segControl: UISegmentedControl!
    
    var arrDetail = [Dictionary<String, Any>]()
    
    let uinfo = UserInfoManager()
    
    var nAddMin: Int = 0
    var nAddFee: Int = 0
    
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
                        nAddMin = Int(strAddMin)!
                        nAddFee = Int(strAddFee)!
                    }
                    
                }
                
                
                if let company = dicData["company"] as? String {
                    uinfo.rCompany = company
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
    
    
    // MARK: - Btn Action
    
    @IBAction func onBtnCancel(_ sender: UIButton) {
        self.tapMainView(self.view)
    }
    
    @IBAction func onBtnExtend(_ sender: UIButton) {
        
        guard let paymentNavi = self.storyboard?.instantiateViewController(withIdentifier: "PaymentNavi") as? UINavigationController else {
            return;
        }
        
        
        let exStartDate = uinfo.stringToDate(uinfo.extendStartTime!)
        var exEndDate: Date = Date()
        
        switch segControl.selectedSegmentIndex {
        case 0:
            exEndDate = exStartDate + 30.minutes
        case 1:
            exEndDate = exStartDate + 1.hours
        case 2:
            exEndDate = exStartDate + 2.hours
        default:
            exEndDate = exStartDate
        }
        
        uinfo.extendEndTime = uinfo.dateToString(exEndDate)
        uinfo.rsvType = "E"
        
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
