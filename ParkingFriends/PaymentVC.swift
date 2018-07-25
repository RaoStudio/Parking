//
//  PaymentVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 24..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let uinfo = UserInfoManager()
    let uSession = UserSession()
    
    var strTotalPay = ""
    var strResTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if let strPay = uinfo.totalPay {
            strTotalPay = strPay
        }
        
        if let strStart = uinfo.startTime, let strEnd = uinfo.endTime {
            
            let startDate = uinfo.stringToDate(strStart)
            let endDate = uinfo.stringToDate(strEnd)
            
            let strS = String(format: "%d-%d-%d %02d:%02d",startDate.year, startDate.month, startDate.day, startDate.hour, startDate.minute)
            let strE = String(format: "%02d:%02d", endDate.hour, endDate.minute)
            
            strResTime = "\(strS) ~ \(strE)"
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.view.frame.origin.y = -(keyboardSize.height/2)
            
            /*
            if (txtCarName.isFirstResponder || txtCarNum.isFirstResponder ){
                self.view.frame.origin.y = -(keyboardSize.height/2)
            }
             */
        }
    }

    
    // MARK: - Btn Action
    @IBAction func onBtnExit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnPayment(_ sender: UIButton) {
    }
    
    
    // MARK: - TableView
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        case 2:
            return 3
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        let nSection = indexPath.section
        let nRow = indexPath.row
        
        if nSection == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "PaymentInfoCell")!
            if let infoCell = cell as? PaymentInfoCell {
                if nRow == 0 {
                    infoCell.lbl_Title.text = "주차장"
                    infoCell.lbl_Contents.text = uinfo.rCompany
                } else if nRow == 1 {
                    infoCell.lbl_Title.text = "예약시간"
                    if !strResTime.isEmpty {
                        infoCell.lbl_Contents.text = strResTime
                    }
                } else {
                    infoCell.lbl_Title.text = "결제금액"
                    if !strTotalPay.isEmpty {
                        infoCell.lbl_Contents.text = "\(strTotalPay.decimalPresent)원"
                    }
                }
            }
        } else if nSection == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "PaymentSelectCell")!
            
            if let selectCell = cell as? PaymentSelectCell {
                
            }
            
        } else if nSection == 2 {
            if nRow == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCoupSelectCell")!
            } else if nRow == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "PaymentPointInputCell")!
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTotalCountCell")!
            }
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "PaymentInfoCell")!
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let nSection = indexPath.section
        let nRow = indexPath.row
        
        if nSection == 0 {
            return 44.0
        } else if nSection == 1 {
            return 127.0
        } else if nSection == 2 {
            return 53.0
        }
        
        return 44.0
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        }
        return 29.0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 13.0)
        
        //        let rect = CGRect(x: 12.0, y: header.frame.origin.y, width: header.frame.size.width - 12.0, height: header.frame.size.height)
        
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        
        var strSection: String
        switch section {
        case 0:
            strSection = ""
        case 1:
            strSection = "결제 방법"
        case 2:
            strSection = "포인트/쿠폰 사용"
        default:
            strSection = ""
        }
        header.textLabel?.text = strSection
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
