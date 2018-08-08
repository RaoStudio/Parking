//
//  ReservHistoryVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 8..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire

class ReservHistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var arrData = [Dictionary<String, Any>]()
    var arrMake = [[Dictionary<String, Any>]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        requestFetchReservationHistory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Btn Action
    @IBAction func onBtnExit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - API ( URL_API_RESERVATION_FETCH_HISTORY )
    func requestFetchReservationHistory() {
        let param = ["reserve_type" : "ALL"] as [String: Any]
        
        Alamofire.request(UrlStrings.URL_API_RESERVATION_FETCH_HISTORY, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_API_RESERVATION_FETCH_HISTORY) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value {
                print("requestFetchReservationHistory JSON = \(value)")
                
                self.arrData = value as! [Dictionary<String, Any>]
            
                self.makeArrayForTableView()
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    func makeArrayForTableView () {
        
        var nIndex: Int = 0
        var strRegDate: String = ""
        var setStrDate = Set<String>()
        
        for item in arrData {
            let strTime = item["reg_datetime"] as! String
            
            let arrTime = strTime.components(separatedBy: " ")
            print(arrTime)
            
            if let strFirst = arrTime.first {
                setStrDate.insert(strFirst)
            }
        }
        print("Count of Set is \(setStrDate.count)")
        
        
        for item in setStrDate {
            var arrInsert = [Dictionary<String, Any>]()
            arrMake.append(arrInsert)
        }
        print(arrMake)
        
        for item in arrData {
            let strTime = item["reg_datetime"] as! String
            let arrTime = strTime.components(separatedBy: " ")
            
            if let strFirst = arrTime.first {
                if strRegDate.isEmpty {
                    strRegDate = strFirst
                }
                
                if strRegDate != strFirst {
                    nIndex = nIndex + 1
                    strRegDate = strFirst
                }
                
                arrMake[nIndex].append(item)
            }
        }
        
        print(arrMake)
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ReservHistoryCell")!
        
        if let resCell = cell as? ReservHistoryCell {
            
            if let dic = arrData[indexPath.row] as? Dictionary<String, Any> {
                if let img: String = dic["img"] as? String {
                    let strImg: String = UrlStrings.URL_API_PARKINGLOT_IMG + img
                    
                    resCell.ivLot.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: "List_NoImage"))
                }
            }
            
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
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
