//
//  PaymentVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 24..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import DropDown

class PaymentVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PaymentSelectProtocol, PaymentPointInputProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    let uinfo = UserInfoManager()
    let uSession = UserSession()
    
    var strTotalPay = "0"
    var strCoupPay = "0"
    var strPointPay = "0"
    
    
    var strLastPay = ""
    
    var strResTime = ""
    var nSelect: Int = 0
    
    let coupDropDown = DropDown()
    var strCoup = ""
    
    var arrCoupPay:Array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if let strPay = uinfo.totalPay {
            strTotalPay = strPay
            strLastPay = strPay
            
            uinfo.lastPay = strLastPay
        }
        
        if let strStart = uinfo.startTime, let strEnd = uinfo.endTime {
            
            let startDate = uinfo.stringToDate(strStart)
            let endDate = uinfo.stringToDate(strEnd)
            
            let strS = String(format: "%d-%d-%d %02d:%02d",startDate.year, startDate.month, startDate.day, startDate.hour, startDate.minute)
            let strE = String(format: "%02d:%02d", endDate.hour, endDate.minute)
            
            strResTime = "\(strS) ~ \(strE)"
        }
        
        strCoup = CouponType.month.rawValue
        
        
        arrCoupPay = [
            CouponValue.month.rawValue,
            CouponValue.launch.rawValue,
            CouponValue.dev.rawValue
        ]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: DropDown
    func setupCoupDropDown(label: UILabel) {
        coupDropDown.anchorView = label
        
//        coupDropDown.topOffset = CGPoint(x: 0, y: label.bounds.height)
        coupDropDown.topOffset = CGPoint(x: 0, y: 0)
        
        coupDropDown.dataSource = [
            CouponType.month.rawValue,
            CouponType.launch.rawValue,
            CouponType.dev.rawValue
        ]
        
        
        
        coupDropDown.direction = .top
        coupDropDown.selectionAction = { [weak self] (index, item) in
            label.text = item
            self?.strCoup = item
            self?.strCoupPay = (self?.arrCoupPay[index])!
            self?.calcLastPay()
        }
    }
    
    func calcLastPay() {
        let nTotal = Int(strTotalPay)
        let nCoupPay = Int(strCoupPay)
        let nPointPay = Int(strPointPay)
        
        strLastPay = "\(nTotal!-nCoupPay!-nPointPay!)"
        
//        self.tableView.reloadData()
        self.tableView.reloadRows(at: [IndexPath(row: 2, section: 2)], with: UITableViewRowAnimation.none)
        
        
        uinfo.lastPay = strLastPay
    }
    
    
    
    // MARK: NotificationCenter
    @objc func keyboardWillHide() {
        self.tableView.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
//            self.tableView.frame.origin.y = -(keyboardSize.height/2)
            self.tableView.frame.origin.y = -(keyboardSize.height)
            
            /*
            if (txtCarName.isFirstResponder || txtCarNum.isFirstResponder ){
                self.view.frame.origin.y = -(keyboardSize.height/2)
            }
             */
        }
    }
    
    // MARK: - PaymentPointInputProtocol
    func onPointChange(strPoint: String) {
        self.strPointPay = strPoint
        print("##\(self.strPointPay)##")
        self.calcLastPay()
    }

    // MARK: - PaymentSelectProtocol
    func onPaymentSelct(nTag: Int) {
        self.nSelect = nTag
        print("onPaymentSelct: \(self.nSelect)")
    }
    
    // MARK: - Btn Action
    @IBAction func onBtnExit(_ sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        /*
        if let vc = self.presentingViewController as? ResCheckVC {
            vc.tapMainView(vc.view)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
         */
    }
    
    @IBAction func onBtnPayment(_ sender: UIButton) {
        
        var strParam: String = ""
        var strPayMethod: String = ""
        
        switch self.nSelect {
            
        case 0: // Credit Card
            
            if strLastPay == "0" {
                if let niceVC = self.storyboard?.instantiateViewController(withIdentifier: "NicePayVC") as? NicePayVC {
                    strParam = "PayMethod=POINT" + "&BuyerName=\(uSession.name!)"
                        + "&BuyerTel=\(uSession.mobile!)" + "&BuyerEmail=\(uSession.email!)"
                        + "&member_sid=\(uSession.sid!)" + "&parkinglot_sid=\(uinfo.lotSid!)"
                        + "&reserve_type=\(uinfo.rsvType!)" + "&begin=\(uinfo.startTime!)"
                        + "&end=\(uinfo.endTime!)" + "&price_ori=\(uinfo.totalPay!)"
                        + "&point=\(strPointPay)" + "&type=nice_etc"
                    
                    niceVC.param = strParam
                    
                    self.navigationController?.pushViewController(niceVC, animated: true)
                }
            }
            else
            {
                if let cardVC = self.storyboard?.instantiateViewController(withIdentifier: "CardVC") as? CardVC {
                    cardVC.strPoint = strPointPay
                    self.navigationController?.pushViewController(cardVC, animated: true)
                }
            }
            
        case 1: // phone
            if let niceVC = self.storyboard?.instantiateViewController(withIdentifier: "NicePayVC") as? NicePayVC {
                
//                var strPayMethod: String = ""
                
                if strLastPay == "0" {
                    strPayMethod = "POINT"
                } else {
                    strPayMethod = "CELLPHONE"
                }
                
                strParam = "PayMethod=\(strPayMethod)" + "&BuyerName=\(uSession.name!)"
                    + "&BuyerTel=\(uSession.mobile!)" + "&BuyerEmail=\(uSession.email!)"
                    + "&member_sid=\(uSession.sid!)" + "&parkinglot_sid=\(uinfo.lotSid!)"
                    + "&reserve_type=\(uinfo.rsvType!)" + "&begin=\(uinfo.startTime!)"
                    + "&end=\(uinfo.endTime!)" + "&price_ori=\(uinfo.totalPay!)"
                    + "&point=\(strPointPay)" + "&type=nice_etc"
                
                niceVC.param = strParam
                
                self.navigationController?.pushViewController(niceVC, animated: true)
            }
            
        case 2: // trasfer
            if let niceVC = self.storyboard?.instantiateViewController(withIdentifier: "NicePayVC") as? NicePayVC {
                
//                var strPayMethod: String = ""
                
                if strLastPay == "0" {
                    strPayMethod = "POINT"
                } else {
                    strPayMethod = "BANK"
                }
                
                strParam = "PayMethod=\(strPayMethod)" + "&BuyerName=\(uSession.name!)"
                    + "&BuyerTel=\(uSession.mobile!)" + "&BuyerEmail=\(uSession.email!)"
                    + "&member_sid=\(uSession.sid!)" + "&parkinglot_sid=\(uinfo.lotSid!)"
                    + "&reserve_type=\(uinfo.rsvType!)" + "&begin=\(uinfo.startTime!)"
                    + "&end=\(uinfo.endTime!)" + "&price_ori=\(uinfo.totalPay!)"
                    + "&point=\(strPointPay)" + "&type=nice_etc"
                
                niceVC.param = strParam
                
                self.navigationController?.pushViewController(niceVC, animated: true)
            }
            
        case 3: // kakao
            if let niceVC = self.storyboard?.instantiateViewController(withIdentifier: "NicePayVC") as? NicePayVC {
                
//                var strPayMethod: String = ""
                
                if strLastPay == "0" {
                    strPayMethod = "POINT"
                } else {
                    strPayMethod = "KAKAO"
                }
                
                strParam = "PayMethod=\(strPayMethod)" + "&BuyerName=\(uSession.name!)"
                    + "&BuyerTel=\(uSession.mobile!)" + "&BuyerEmail=\(uSession.email!)"
                    + "&member_sid=\(uSession.sid!)" + "&parkinglot_sid=\(uinfo.lotSid!)"
                    + "&reserve_type=\(uinfo.rsvType!)" + "&begin=\(uinfo.startTime!)"
                    + "&end=\(uinfo.endTime!)" + "&price_ori=\(uinfo.totalPay!)"
                    + "&point=\(strPointPay)" + "&type=kakao"
                
                niceVC.param = strParam
                
                self.navigationController?.pushViewController(niceVC, animated: true)
            }
            
        default:
            ()
        }
        
        
    }
    
    
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
                selectCell.delegate = self
            }
            
        } else if nSection == 2 {
            if nRow == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCoupSelectCell")!
                if let coupCell = cell as? PaymentCoupSelectCell {
                    coupCell.lbl_Title.text = self.strCoup
                    coupCell.lbl_Count.text = "\(strCoupPay.decimalPresent)원"
                }
                
            } else if nRow == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "PaymentPointInputCell")!
                if let pointCell = cell as? PaymentPointInputCell {
                    
                    pointCell.delegate = self
                    
                    if let nPoint = uSession.point {
                        let strPoint = String(format: "%d", nPoint)
                        pointCell.lbl_Point.text = "\(strPoint.decimalPresent)P"
                    }
                }
                
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTotalCountCell")!
                if let totalCell = cell as? PaymentTotalCountCell {
                    if !strLastPay.isEmpty {
                        totalCell.lbl_TotalCount.text = "\(strLastPay.decimalPresent) 원"
                    }
                }
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        tableView.deselectRow(at: indexPath, animated: true)
        
        let nSection = indexPath.section
        let nRow = indexPath.row
        
        print("%d:Section %d:Row", nSection, nRow)
        
        if nSection == 2 {
            if nRow == 0 {
                let cell = tableView.cellForRow(at: indexPath)
                if let CoupSelectCell = cell as? PaymentCoupSelectCell {
                    self.setupCoupDropDown(label: CoupSelectCell.lbl_Title)
                    self.coupDropDown.show()
                }
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
