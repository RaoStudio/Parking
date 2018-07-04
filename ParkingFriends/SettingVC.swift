//
//  SettingVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 4..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import DropDown



class SettingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    let uinfo = UserInfoManager()
    
    
    let radiusDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if nSection == 2 {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
