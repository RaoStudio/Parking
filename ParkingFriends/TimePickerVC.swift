//
//  TimePickerVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 15..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import DropDown
import SwiftDate

class TimePickerVC: UIViewController {

    @IBOutlet var startPicker: UIDatePicker!
    @IBOutlet var endPicker: UIDatePicker!
    
    @IBOutlet var btnStart: UIButton!
    @IBOutlet var btnEnd: UIButton!
    
    
    var subTitle: UILabel!
    
    let startDropDown = DropDown()
    let endDropDown = DropDown()
    
    let uinfo = UserInfoManager()
    
    
    
    var strNow: String = ""
    var strOne: String = ""
    var strTwo: String = ""
    
    
    var tempDay: Date = Date()
    
    var arrDay: [Date] = []
    
    var arrImpossibleTime: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "주차시간 선택"
        
        /*
        if let nItem = self.navigationController?.navigationItem {
            nItem.title = "주차시간 선택"
        }
         */
        
        
        /*
        startPicker.minimumDate = Date()
        startPicker.maximumDate = Date(timeInterval: 60*60*24*2, since: Date())
         */
        
        let startDate = uinfo.stringToDate(uinfo.startTime!)
        startPicker.minimumDate = startDate
        startPicker.date = startDate
        
        let endDate = uinfo.stringToDate(uinfo.endTime!)
        endPicker.minimumDate = endDate
        endPicker.date = endDate
        
        /*
        strNow = uinfo.startTime!
        strOne = uinfo.dateToString(startDate+1.day)
        strTwo = uinfo.dateToString(startDate+2.day)
        */
        
        
//        strDistance = String(format: "%.0fm", distance)
        
        let oneDate = startDate + 1.day
        let twoDate = startDate + 2.day
        
        
        /*
        arrDay.append(startDate)
        arrDay.append(oneDate)
        arrDay.append(twoDate)
 */
        
        arrDay = [startDate, oneDate, twoDate]
        
//        strOne = uinfo.dateToString(startDate+1.day)
//        strTwo = uinfo.dateToString(startDate+2.day)
        
        strNow = String(format: "%d년%02d월%02d일(%@)", startDate.year, startDate.month, startDate.day, startDate.weekdayName)
        strOne = String(format: "%d년%02d월%02d일(%@)", oneDate.year, oneDate.month, oneDate.day, oneDate.weekdayName)
        strTwo = String(format: "%d년%02d월%02d일(%@)", twoDate.year, twoDate.month, twoDate.day, twoDate.weekdayName)
        
        
        
        btnStart.setTitle(strNow, for: UIControlState.normal)
        btnEnd.setTitle(strNow, for: UIControlState.normal)
        

        setupStartDropDown()
        setupEndDropDown()
        
        
        startPicker.addTarget(self, action: #selector(valueChanged(_:)), for: UIControlEvents.valueChanged)
        endPicker.addTarget(self, action: #selector(valueChanged(_:)), for: UIControlEvents.valueChanged)
        
        
        self.initTitleTwoLine()
        
        // Test
//        arrImpossibleTime = ["1111","2222","3333"]
        
//        self.startPicker.setLimit(forCalendarComponent: .day, minimumUnit: 0, maximumUnit: 2)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom ( Navigation Title )
    func initTitleTwoLine() {
        let containerView = UIView(frame:CGRect(x: 0, y: 0, width: 200, height: 36))
        
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        topTitle.textColor = UIColor.black
        topTitle.text = "주차시간 선택"
        
        
        subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 15)
        subTitle.textColor = hexStringToUIColor(hex: "#22d158")
        subTitle.text = ""
        
        
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        
        self.navigationItem.titleView = containerView
        
        
//        let color = UIColor(red:0.02, green:0.22, blue:0.49, alpha:1.0)
//        self.navigationController?.navigationBar.barTintColor = color
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
        startDropDown.selectRow(0)
        
        startDropDown.selectionAction = { [weak self] (index, item) in
            
            if self?.btnStart.title(for: UIControlState.normal) == item {
                return
            }
            
            self?.btnStart.setTitle(item, for: UIControlState.normal)
            
            let nowDate = self?.startPicker.date
            let selDate = self?.arrDay[index]
            
            
//            self?.startPicker.date = (self?.arrDay[index])!
            
            let nHourGap = (nowDate?.hour)! - (selDate?.hour)!
            
            self?.startPicker.date = (self?.arrDay[index])! + nHourGap.hour
            
            self?.valueChanged((self?.startPicker)!)
        }
    }
    
    func setupEndDropDown() {
        endDropDown.textFont = UIFont.systemFont(ofSize: 13)
        endDropDown.anchorView = self.btnEnd
        endDropDown.bottomOffset = CGPoint(x: 0, y: self.btnEnd.bounds.height)
        
        endDropDown.dataSource = [
            strNow,
            strOne,
            strTwo
        ]
        
        endDropDown.direction = .bottom
        endDropDown.selectRow(0)
        
        endDropDown.selectionAction = { [weak self] (index, item) in
            
            if self?.btnEnd.title(for: UIControlState.normal) == item {
                return
            }
            
            self?.btnEnd.setTitle(item, for: UIControlState.normal)
            
            let nowDate = self?.endPicker.date
            let selDate = self?.arrDay[index]
            
            
            let nHourGap = (nowDate?.hour)! - (selDate?.hour)!
            
            self?.endPicker.date = (self?.arrDay[index])! + nHourGap.hour
            
            self?.valueChanged((self?.endPicker)!)
        }
    }
    
    
    // MARK: - Action
    @IBAction func onBtnStart(_ sender: UIButton) {
        startDropDown.show()
    }
    
    
    @IBAction func onBtnEnd(_ sender: UIButton) {
        endDropDown.show()
    }
    
    
    @objc func valueChanged(_ sender: UIDatePicker) {
        /*
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .medium
        let date = dateformatter.string(from: sender.date)
        self.navigationItem.title = date
         */
       
        let startDay = self.startPicker.date
        let endDay = self.endPicker.date
        
        let nTime = endDay - startDay
        
        guard let strTime = try? nTime.string() else {
            return
        }
        
        /*
        if nTime < 3600 {
            self.navigationItem.title = "주차시간 ( 주차불가 )"
        } else {
            self.navigationItem.title = "주차시간 ( \(strTime) )"
        }
         */
        
        if nTime < 3600 {
            self.subTitle.textColor = hexStringToUIColor(hex: "#ff3c4a")
            self.subTitle.text = "예약불가"
        } else {
            self.subTitle.textColor = hexStringToUIColor(hex: "#22d158")
            self.subTitle.text = strTime
        }
    }
    
    
    func setUpTimePicker() {
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        minDateComponent.day = 01
        minDateComponent.month = 06
        minDateComponent.year = 2018
        
        let minDate = calendar.date(from: minDateComponent)
        print(" min date : \(String(describing: minDate))")
        
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        maxDateComponent.day = 0
        maxDateComponent.month = 06 + 1
        maxDateComponent.year = 2018
        
        let maxDate = calendar.date(from: maxDateComponent)
        print("max date : \(String(describing: maxDate))")
        
        startPicker.minimumDate = minDate! as Date
        startPicker.maximumDate =  maxDate! as Date
    }

    // MARK: - Action
    @IBAction func onBtnExit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnOk(_ sender: UIButton) {
//        self.alert("Test\nTest\nTest\n")
        
        var strImpossible: String = ""
        if let arrImpossible = arrImpossibleTime {
            
            for (ix,v) in arrImpossible.enumerated(){
                strImpossible.append(v)
            }
            
            self.alert(strImpossible) {
                self.onBtnOkCompletion(sender)
            }
        } else {
            onBtnOkCompletion(sender)
        }
        
    }
    
    func onBtnOkCompletion(_ sender: UIButton) {
        let startDay = self.startPicker.date
        let endDay = self.endPicker.date
        
        let nTime = endDay - startDay
        
        if nTime < 0 {
            self.alert("출차시간이 입차시간보다 작습니다.")
            return
        }
        else if nTime >= 0 && nTime < 3600 {
            self.alert("예약은 1시간 이상 설정해야 합니다.")
            return
        }
        
        
        let startDate = startPicker.date
        let endDate = endPicker.date
        
        let strStart = uinfo.dateToString(startDate)
        let strEnd = uinfo.dateToString(endDate)
        
        uinfo.startTime = strStart
        uinfo.endTime = strEnd
        
        
        if let myNC = self.navigationController {
            if let nc = myNC.presentingViewController as? UINavigationController {
                
                if let vc = nc.topViewController as? MainViewController {
                
                    vc.reserveFromTimePick()
                }
            }
        }
        
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        // Commit Test // Commit Test
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

extension UIDatePicker {
    
    /*
    func setLimit(forCalendarComponent component:Calendar.Component, minimumUnit min: Int, maximumUnit max: Int) {
        
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        guard let timeZone = TimeZone(identifier: "UTC") else { return }
        calendar.timeZone = timeZone
        
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        
        components.setValue(-min, for: component)
        if let maxDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.maximumDate = maxDate
        }
        
        components.setValue(-max, for: component)
        if let minDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.minimumDate = minDate
        }
    }
    */
}
