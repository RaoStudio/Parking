//
//  StartTimePickerVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 9. 12..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import DropDown
import SwiftDate

class StartTimePickerVC: UIViewController {

    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var btnStart: UIButton!
    
    
    var endDate: Date = Date()
    
    
    let startDropDown = DropDown()
    
    let uinfo = UserInfoManager()
    
    var strNow: String = ""
    var strOne: String = ""
    var strTwo: String = ""
    
    
    var arrDay: [Date] = []
    
    var arrImpossibleTime: [String]?
    var arrArrangeImpossible: [[String]]?
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let startDate = uinfo.stringToDate(uinfo.startTime!)
        startPicker.minimumDate = startDate
        startPicker.date = startDate
        
        
        endDate = uinfo.stringToDate(uinfo.endTime!)
        
        
        
        let firstDate = uinfo.stringToDate(uinfo.firstTime!)
        let oneDate = uinfo.stringToDate(uinfo.secondTime!)
        let twoDate = uinfo.stringToDate(uinfo.thirdTime!)
        
        arrDay = [firstDate, oneDate, twoDate]
        
//        strNow = String(format: "%d년%02d월%02d일(%@)", firstDate.year, firstDate.month, firstDate.day, firstDate.weekdayName)
//        strOne = String(format: "%d년%02d월%02d일(%@)", oneDate.year, oneDate.month, oneDate.day, oneDate.weekdayName)
//        strTwo = String(format: "%d년%02d월%02d일(%@)", twoDate.year, twoDate.month, twoDate.day, twoDate.weekdayName)
        
        
        strNow = String(format: "%d년%02d월%02d일(%@)", firstDate.year, firstDate.month, firstDate.day, DayNameType.allValues[firstDate.weekday-1].rawValue)
        strOne = String(format: "%d년%02d월%02d일(%@)", oneDate.year, oneDate.month, oneDate.day, DayNameType.allValues[oneDate.weekday-1].rawValue)
        strTwo = String(format: "%d년%02d월%02d일(%@)", twoDate.year, twoDate.month, twoDate.day, DayNameType.allValues[twoDate.weekday-1].rawValue)
        
        
        
        setupStartDropDown()
        
        btnStart.setTitle(startDropDown.selectedItem, for: UIControlState.normal)
        
        startPicker.addTarget(self, action: #selector(valueChanged(_:)), for: UIControlEvents.valueChanged)
        
        arrangeImpossibleTime(arrTime: arrImpossibleTime)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SetUpDropDown
    func setupStartDropDown() {
        
        startDropDown.textFont = UIFont.systemFont(ofSize: 13)
        startDropDown.anchorView = self.btnStart
        startDropDown.bottomOffset = CGPoint(x: 0, y: self.btnStart.bounds.height)
        
        startDropDown.dataSource = [
            strNow,
            strOne,
            strTwo
        ]
        
        startDropDown.direction = .bottom
        startDropDown.selectRow(uinfo.nFirstTime!)
        
        startDropDown.selectionAction = { [weak self] (index, item) in
            
            if self?.btnStart.title(for: UIControlState.normal) == item {
                return
            }
            
            //            self?.uinfo.nFirstTime = index
            
            self?.btnStart.setTitle(item, for: UIControlState.normal)
            
            let nowDate = self?.startPicker.date
            let selDate = self?.arrDay[index]
            
            
            //            self?.startPicker.date = (self?.arrDay[index])!
            
            let nHourGap = (nowDate?.hour)! - (selDate?.hour)!
            
            self?.startPicker.date = (self?.arrDay[index])! + nHourGap.hour
            
            self?.valueChanged((self?.startPicker)!)
            
            print(self?.startPicker.date)
            print(self?.uinfo.dateToString((self?.startPicker.date)!))
        }
    }
    
    
    // MARK: - Arrange Impossible Time ~
    func arrangeImpossibleTime(arrTime: Array<String>?) {
        /*
         guard arrTime?.isEmpty == false else {
         return
         }
         */
        
        guard let arrImpossible = arrTime else {
            return
        }
        
        print(arrImpossible)
        
        arrArrangeImpossible = [[String]]()
        
        var arrValue: [String]?
        
        for (index, value) in arrImpossible.enumerated() {
            print("\(index): \(value)")
            
            if (index % 2 == 0) {
                arrValue = [String]()
                arrValue?.append(value)
            } else {
                arrValue?.append(value)
                arrArrangeImpossible?.append(arrValue!)
            }
        }
        
        print(arrArrangeImpossible!)
        
        
    }
    
    // MARK: - Reserve Time to Impossible Time
    func calcImpossibleTime(arrTime: [[String]], endDay: Date) -> Bool {
        
        let startDay = self.startPicker.date
        
        for item in arrTime {
            
            if let strSTime = item.first, let strETime = item.last {
                let sTime = uinfo.stringToDate(strSTime)
                let eTime = uinfo.stringToDate(strETime)
                
                let bStartDayEnable = startDay.isBetween(date: sTime, and: eTime)
                let bEndDayEnable = endDay.isBetween(date: sTime, and: eTime)
                
                let bStartEnable = sTime.isBetween(date: startDay, and: endDay)
                let bEndEnable = eTime.isBetween(date: startDay, and: endDay)
                
                if bStartDayEnable == true {
                    print("calcImpossibleTime return false: \(sTime) ~ \(eTime) : \(startDay)")
                    return true
                }
                
                if bEndDayEnable == true {
                    print("calcImpossibleTime return false: \(sTime) ~ \(eTime) : \(startDay)")
                    return true
                }
                
                if bStartEnable == true {
                    print("calcImpossibleTime return false: \(sTime) ~ \(eTime) : \(startDay)")
                    return true
                }
                
                if bEndEnable == true {
                    print("calcImpossibleTime return false: \(sTime) ~ \(eTime) : \(endDay)")
                    return true
                }
            }
        }
        
        
        return false
    }
    
    // MARK: - Btn Action
    @IBAction func onBtnExit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnStart(_ sender: UIButton) {
        startDropDown.show()
    }
    
    @objc func valueChanged(_ sender: UIDatePicker) {
        
    }
    
    @IBAction func onBtnOk(_ sender: UIButton) {
        print("StartTimeVC : OnBtnOk~ ")
        print(self.startPicker.date)
        print(self.uinfo.dateToString(self.startPicker.date))
        print("\n")
        
        
        let startDay = self.startPicker.date
        
        
        if startDay < uinfo.stringToDate(uinfo.firstTime!) {
            self.alert("지나간 시간입니다.")
            return
        }
        
        let endDay = startDay + (self.uinfo.endHours?.hours)!
        
        if let arrImpossible = arrImpossibleTime {
            
            var strImpossible: String = ""
            
            if let arrArrange = arrArrangeImpossible, arrArrange.isEmpty == false {
                let bResult = self.calcImpossibleTime(arrTime: arrArrange, endDay: endDay)
                
                if bResult == true {
                    for (index, value) in arrImpossible.enumerated(){
                        
                        let dateValue = uinfo.stringToDate(value)
                        let strValue = String(format: "%02d/%02d일 %02d:%02d", dateValue.month, dateValue.day, dateValue.hour, dateValue.minute)
                        
                        if (index % 2 == 0) {
                            strImpossible.append(strValue)
                            strImpossible.append(" ~ ")
                        } else {
                            strImpossible.append(strValue)
                            strImpossible.append("\n\n")
                        }
                        
                        //                        strImpossible.append(value)
                    }
                    
                    
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImpossibleVC") as? ImpossibleVC else {
                        return
                    }
                    
                    vc.bTab = false
                    vc.strImpossible = strImpossible
                    
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: false, completion: nil)
                    
                    return
                }
            }
        }
        
        
        
        let startDate = startPicker.date
        
        
        let strStart = uinfo.dateToString(startDate)
        let strEnd = uinfo.dateToString(endDay)
        
        uinfo.startTime = strStart
        uinfo.endTime = strEnd
        
        
        uinfo.nFirstTime = startDropDown.indexForSelectedRow
        
        
        if let myNC = self.navigationController {
            if let nc = myNC.presentingViewController as? UINavigationController {
                
                if let vc = nc.topViewController as? MainViewController {
                    
                    vc.reserveFromTimePick()
                }
            }
        }
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
