//
//  ReserveExtendVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 16..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire

class ReserveExtendVC: PresentTestVC {

    @IBOutlet weak var segControl: UISegmentedControl!
    
    var arrDetail = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        segControl.layer.cornerRadius = 16
        segControl.layer.borderWidth = 1
        segControl.layer.borderColor = segControl.tintColor.cgColor
        segControl.layer.masksToBounds = true
        
//        segControl.setEnabled(false, forSegmentAt: 0)
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
        
        self.present(paymentNavi, animated: true, completion: nil)
 
        
        print("\(segControl.selectedSegmentIndex)")
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
