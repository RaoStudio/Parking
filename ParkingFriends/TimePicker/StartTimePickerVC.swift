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
        
        strNow = String(format: "%d년%02d월%02d일(%@)", firstDate.year, firstDate.month, firstDate.day, firstDate.weekdayName)
        strOne = String(format: "%d년%02d월%02d일(%@)", oneDate.year, oneDate.month, oneDate.day, oneDate.weekdayName)
        strTwo = String(format: "%d년%02d월%02d일(%@)", twoDate.year, twoDate.month, twoDate.day, twoDate.weekdayName)
        
        
        setupStartDropDown()
        
        btnStart.setTitle(startDropDown.selectedItem, for: UIControlState.normal)
        
        startPicker.addTarget(self, action: #selector(valueChanged(_:)), for: UIControlEvents.valueChanged)
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
            
//            print(self?.startPicker.date)
        }
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
        
        let startDay = self.startPicker.date
        
        if startDay < uinfo.stringToDate(uinfo.firstTime!) {
            self.alert("지나간 시간입니다.")
            return
        }
        
        
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
