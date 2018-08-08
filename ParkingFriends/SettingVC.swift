//
//  SettingVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 4..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import DropDown

import UserNotifications

class SettingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var lblRadius: UILabel?
    
    var viewEntry: UIView?
    var viewExit: UIView?
    
    
    var lblEntry: UILabel?
    var lblExit: UILabel?
    
    
    @IBOutlet var btnExit: UIBarButtonItem!
    
    let uinfo = UserInfoManager()
    
    
    let radiusDropDown = DropDown()
    let alarmDropDown = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //*
        radiusDropDown.dataSource = [
            RadiusType.fiveH.rawValue,
            RadiusType.oneT.rawValue,
            RadiusType.fiveT.rawValue,
            RadiusType.tenT.rawValue
        ]
        //*/
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, Error) in
            
        }
        
        UNUserNotificationCenter.current().delegate = self
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - DropDown
    func setupRadiusDropDown() {
        radiusDropDown.anchorView = self.lblRadius
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        radiusDropDown.topOffset = CGPoint(x: 0, y: (self.lblRadius?.bounds.height)!)
        
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        /*
        radiusDropDown.dataSource = [
            RadiusType.fiveH.rawValue,
            RadiusType.oneT.rawValue,
            RadiusType.fiveT.rawValue,
            RadiusType.tenT.rawValue
        ]
        */
        
        
        radiusDropDown.direction = .bottom
        // Action triggered on selection
        radiusDropDown.selectionAction = { [weak self] (index, item) in
//            self?.btnRadius.setTitle(item, for: .normal)
//            self?.radiusPicker(strRadius: item)
            
            self?.lblRadius?.text = item
            self?.uinfo.radius = item
        }
    }
    
    
    func setupAlarmDropDown(label: UILabel, bEntry: Bool) {
        alarmDropDown.anchorView = label
        
        radiusDropDown.topOffset = CGPoint(x: 0, y: label.bounds.height)
        
        alarmDropDown.dataSource = [
            UserAlarmType.none.rawValue,
            UserAlarmType.appoint.rawValue,
            UserAlarmType.one.rawValue,
            UserAlarmType.three.rawValue,
            UserAlarmType.five.rawValue,
            UserAlarmType.ten.rawValue,
            UserAlarmType.fifteen.rawValue,
            UserAlarmType.twenty.rawValue,
            UserAlarmType.thirty.rawValue,
            UserAlarmType.hour.rawValue
        ]
        
        alarmDropDown.direction = .bottom
        alarmDropDown.selectionAction = { [weak self] (index, item) in
            label.text = item
            
            if self?.uinfo.isUserAlarm == true {
                self?.setUserAlarmNotification()
            }
        }
        
        
    }
    

    
    // MARK: - Button Action
    @IBAction func onBtnExit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        let nSection = indexPath.section
        let nRow = indexPath.row
        
        if nSection == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "SetRadiusCell")!
            
            if let radiusCell = cell as? SetRadiusCell {
                radiusCell.lblRadius.text = uinfo.radius ?? RadiusType.fiveH.rawValue
            }
            
        } else if nSection == 1 {
            
            if nRow == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "SetNoticeCell")!
                if let noticeCell = cell as? SetNoticeCell {
                    let bUse = uinfo.isUserAlarm ?? false
                    noticeCell.btnCheck.isSelected = bUse
                }
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "SetAlarmCell")!
                if let alarmCell = cell as? SetAlarmCell {
                    if nRow == 1 {
                        alarmCell.lblTitle.text = "입차시간 알림"
                    } else {
                        alarmCell.lblTitle.text = "출차시간 알림"
                    }
                }
            }
        } else if nSection == 2 {
            if nRow == 4 {
                cell = tableView.dequeueReusableCell(withIdentifier: "SetVersionCell")!
                if let versionCell = cell as? SetVersionCell {
                    
//                    let versionCode = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
//                    let buildNumber = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
                    versionCell.lblVersion.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
                }
                
                
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "SetInfoAuthCell")!
                if let infoAuthCell = cell as? SetInfoAuthCell {
                    var strTitle: String
                    
                    
                    switch nRow {
                    case 0:
                        strTitle = "사업자 정보"
                    case 1:
                        strTitle = "이용약관"
                    case 2:
                        strTitle = "개인정보 취급방식"
                    case 3:
                        strTitle = "위치기반 서비스 이용약관"
                    default:
                        strTitle = "사업자정보"
                    }
                    
                    
                    infoAuthCell.lblTitle.text = strTitle
                }
            }
            
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "SetRadiusCell")!
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let nSection = indexPath.section
        let nRow = indexPath.row
        
        if nSection == 0 {
            return 53.0
        } else if nSection == 1 {
            if nRow == 0 {
                return 88.0
            } else {
                return 53.0
            }
            
        } else if nSection == 2 {
            if nRow == 4 {
                return 53.0
            } else {
                return 44.0
            }
        }
        
        return 44.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 29.0        
    }

    
    //*
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
            strSection = "지도"
        case 1:
            strSection = "알림"
        case 2:
            strSection = "서비스 정보"
        default:
            strSection = ""
        }
        header.textLabel?.text = strSection
    }
    //*/
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let nSection = indexPath.section
        let nRow = indexPath.row
        
        if nSection == 0 {
//            var cell = tableView.dequeueReusableCell(withIdentifier: "SetRadiusCell")!
            let cell = tableView.cellForRow(at: indexPath)
            if let radiusCell = cell as? SetRadiusCell {
                self.lblRadius = radiusCell.lblRadius
                self.setupRadiusDropDown()
                self.radiusDropDown.show()
            }
        } else if nSection == 1 {
            
            if nRow == 0 {
                let cell = tableView.cellForRow(at: indexPath)
                if let noticeCell = cell as? SetNoticeCell {
                    
                    noticeCell.onBtnCheck(noticeCell.btnCheck)
                    uinfo.isUserAlarm = noticeCell.btnCheck.isSelected
                    
                    
                    if uinfo.isUserAlarm == false {
                        let nextIndex = IndexPath(row: 1, section: 1)
                        
                        let nextCell = tableView.cellForRow(at: nextIndex)
                        if let alarmCell = nextCell as? SetAlarmCell {
                            alarmCell.lblTime.text = UserAlarmType.none.rawValue
                        }
                        
                        let nextIndex2 = IndexPath(row: 2, section: 1)
                        
                        let nextCell2 = tableView.cellForRow(at: nextIndex2)
                        if let alarmCell2 = nextCell2 as? SetAlarmCell {
                            alarmCell2.lblTime.text = UserAlarmType.none.rawValue
                        }
                      
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                    
                }
                
            } else if nRow == 1 && uinfo.isUserAlarm == true {
                let cell = tableView.cellForRow(at: indexPath)
                if let alarmCell = cell as? SetAlarmCell {
                    self.lblEntry = alarmCell.lblTime
                    self.setupAlarmDropDown(label: self.lblEntry!, bEntry: true)
                    self.alarmDropDown.show()
                }
                
            } else if nRow == 2 && uinfo.isUserAlarm == true{
                let cell = tableView.cellForRow(at: indexPath)
                if let alarmCell = cell as? SetAlarmCell {
                    self.lblEntry = alarmCell.lblTime
                    self.setupAlarmDropDown(label: self.lblEntry!, bEntry: false)
                    self.alarmDropDown.show()
                }
            }
        }
        else if nSection == 2 {
            if nRow != 4 {
                if let agreeVC = self.storyboard?.instantiateViewController(withIdentifier: "AgreeInfoVC") as? AgreeInfoVC {
                    
                    var nTag = nRow-1
                    
                    if nTag < 0 {
                        nTag = 3
                    }
                    
                    agreeVC.nTag = nTag
                    self.navigationController?.pushViewController(agreeVC, animated: true)
                }
            }
        }
        
    }
    
    // MARK: - UNUserNotificationCenter
    func setUserAlarmNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Title Test"
        content.subtitle = "Subtitle Test"
        content.body = "Alarm ~~"
        content.sound = UNNotificationSound.default()
        
        // UNCalendarNotificationTrigger
        let date = Date(timeIntervalSinceNow: 5)
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let Calendartrigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
        
        // Use TimeIntervalNotificationTrigger
        let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: Calendartrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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

extension SettingVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}

