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
    var arrSection = [String]()
    var nSection: Int = 0
    
    let uinfo = UserInfoManager()
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
//        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        self.tableView.reloadData()
        refreshControl.endRefreshing() 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        requestFetchReservationHistory()
        
        self.tableView.addSubview(self.refreshControl)
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
                self.alert("\(UrlStrings.URL_API_RESERVATION_FETCH_HISTORY) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value {
                print("requestFetchReservationHistory JSON = \(value)")
                
                self.arrData = value as! [Dictionary<String, Any>]
            
                self.makeArrayForTableView()
                
//                self.tableView.reloadData()
            }
        }
    }
    
    
    func makeArrayForTableView () {
        
        var nIndex: Int = 0
        var strRegDate: String = ""
        var setStrDate = Set<String>()
        
        for item in arrData {
//            let strTime = item["reg_datetime"] as! String
            let strTime = item["end_datetime"] as! String
            
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
//            arrSection.append(item)
        }
        print(arrMake)
        
        nSection = arrSection.count
        
        for item in arrData {
//            let strTime = item["reg_datetime"] as! String
            let strTime = item["end_datetime"] as! String
            let arrTime = strTime.components(separatedBy: " ")
            
            if let strFirst = arrTime.first {
                if strRegDate.isEmpty {
                    strRegDate = strFirst
                    arrSection.append(strRegDate)
                }
                
                if strRegDate != strFirst {
                    nIndex = nIndex + 1
                    strRegDate = strFirst
                    arrSection.append(strRegDate)
                }
                
                arrMake[nIndex].append(item)
            }
        }
        
//        print(arrMake)
        self.tableView.reloadData()
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSection.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMake[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ReservHistoryCell")!
        
        if let resCell = cell as? ReservHistoryCell {
            
            if let dic = arrMake[indexPath.section][indexPath.row] as? Dictionary<String, Any> {
                if let img: String = dic["img"] as? String {
                    let strImg: String = UrlStrings.URL_API_PARKINGLOT_IMG + img
                    
                    resCell.ivLot.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: "List_NoImage"))
//                    let img = resCell.ivLot.image
//                    resCell.ivLot.image = img?.noir
                    
                    resCell.lbl_Name.text = dic["company"] as! String
                    resCell.lbl_Address.text = dic["address"] as! String
                    
                    resCell.lbl_Time.text = uinfo.displayDuringTime(startTime: dic["begin_datetime"] as! String, endTime: dic["end_datetime"] as! String)
                    
                    resCell.lbl_Price.text = "\(dic["price"] as! String)원"
                    
                    if uinfo.isAvailableTime(endTime: dic["end_datetime"] as! String) {
                        
                        if let strMin = uinfo.calcleftTime(startTime: dic["begin_datetime"] as! String, endTime: dic["end_datetime"] as! String) {
                            resCell.lbl_Status.text = "\(strMin)분 남음"
                            resCell.lbl_Status.textColor = hexStringToUIColor(hex: "#22d158")
                        } else {
                        
                           resCell.lbl_Status.text = "예약"
                            resCell.lbl_Status.textColor = hexStringToUIColor(hex: "#13b6f7")
                        }
                        
                        
                        
                        
                        
//                        let img = resCell.ivLot.image
//                        resCell.ivLot.image = img
                        
                        resCell.viewEnd.isHidden = true
                        
                        
                        resCell.lbl_Name.textColor = hexStringToUIColor(hex: "#000000")
                        resCell.lbl_Time.textColor = hexStringToUIColor(hex: "#000000")
                        resCell.lbl_Price.textColor = hexStringToUIColor(hex: "#000000")
                        
                        
                        
                    } else {
                        resCell.lbl_Status.text = "완료"
                        
//                        let img = resCell.ivLot.image
//                        resCell.ivLot.image = img?.noir
                        
                        
                        resCell.viewEnd.isHidden = false
                        
                        
                        resCell.lbl_Name.textColor = hexStringToUIColor(hex: "#888888")
                        resCell.lbl_Time.textColor = hexStringToUIColor(hex: "#888888")
                        resCell.lbl_Price.textColor = hexStringToUIColor(hex: "#888888")
                        
                        resCell.lbl_Status.textColor = hexStringToUIColor(hex: "#888888")
                    }
                    
                    
                    
                }
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 29.0
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 13.0)
        
        //        let rect = CGRect(x: 12.0, y: header.frame.origin.y, width: header.frame.size.width - 12.0, height: header.frame.size.height)
        
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        header.textLabel?.text = arrSection[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReserveDetailVC") as? ReserveDetailVC else {
            return
        }
        
        if let dic = arrMake[indexPath.section][indexPath.row] as? Dictionary<String, Any> {
            if let strSid: String = dic["sid"] as? String, let strLotSid: String = dic["parkinglot_sid"] as? String {
                
                //*
                let cell = tableView.cellForRow(at: indexPath)
                if let resHistoryCell = cell as? ReservHistoryCell {
                
                    vc.strName = resHistoryCell.lbl_Name.text!
                    vc.strStatus = resHistoryCell.lbl_Status.text!
                    vc.strAddress = resHistoryCell.lbl_Address.text!
                    vc.strTime = resHistoryCell.lbl_Time.text!
                    vc.strPrice = resHistoryCell.lbl_Price.text!
                    
                    
                    
                    vc.resSid = strSid
                    vc.strLotSid = strLotSid
                    uinfo.lotSid = strLotSid    // For Extend Payment
                    uinfo.extend = strSid
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                //*/
                
//                vc.resSid = strSid
//                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
        
        
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
