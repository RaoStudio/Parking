//
//  SideVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 25..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class SideVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var constLogout: NSLayoutConstraint!     // orig 187
    @IBOutlet weak var constLogin: NSLayoutConstraint!      // orig 173
    
    
    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCar: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    let uSession = UserSession()
    var bFirstLogon = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
//        constLogin.constant = 0.0     // 5S Test
        
        
        
        self.ivThumb.layer.cornerRadius = self.ivThumb.frame.width/2
        self.ivThumb.layer.masksToBounds = true
        
        
        self.setupLogon()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func setupLogon() {
        if let bLogin = uSession.isLogin, bLogin == true, bFirstLogon == true {
            //            self.updateProfile()
            //            bFirstLogon = false
            
            
            
            let strPoint = String(format: "%d", uSession.point!)
            
            constLogout.constant = 0.0
            constLogin.constant = 173.0
            
            lblName.text = uSession.name
//            lblPoint.text = String(format: "%d P", uSession.point!)
            lblPoint.text = String(format: "%@ P", strPoint.decimalPresent)
            lblEmail.text = uSession.email
            lblCar.text = uSession.carName
            
            if let strPhoto = uSession.photoUrl, false == strPhoto.isEmpty {
                self.ivThumb.sd_setImage(with: URL(string: strPhoto), placeholderImage: UIImage(named: "Side_pf_logo"))
            }
            
        } else {
            constLogout.constant = 187.0
            constLogin.constant = 0.0
        }
    }
    
    // MARK: - API
    func updateProfile() {
        let url = UrlStrings.URL_API_USER_GET
        Alamofire.request(url).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("\(url) : \(String(describing: response.result.error))")
                self.alert("\(url) : \(String(describing: response.result.error))")
                return
            }
        }
        
    }
    
    
    
    
    @IBAction func onBtnLogin(_ sender: UIButton) {
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    @IBAction func onBtnSetting(_ sender: UIButton) {
        guard let setVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingNavi") as? UINavigationController else {
            return
        }
        
        self.present(setVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func onBtnFaq(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Notice", bundle: Bundle.main)
        
        guard let FaqNavi = sb.instantiateViewController(withIdentifier: "FaqNavi") as? UINavigationController else {
            return
        }
        
        guard let vc = FaqNavi.topViewController as? FaqVC else {
            return
        }
        
        self.present(FaqNavi, animated: true, completion: nil)
    }
    
    @IBAction func onBtnQuestion(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Question", bundle: Bundle.main)
        
        guard  let QuestionNavi = sb.instantiateViewController(withIdentifier: "QuestionNavi") as? UINavigationController else {
            return
        }
        
        guard let vc = QuestionNavi.topViewController as? QuestionVC else {
            return
        }
        
        self.present(QuestionNavi, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onBtnTest(_ sender: Any) {
        guard let RegisterNavi = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? UINavigationController else {
            return
        }
        
        self.present(RegisterNavi, animated: true, completion: nil)
    }
    
    
    @IBAction func onBtnLogoutTest(_ sender: UIButton) {
        uSession.initUserSession()
        self.setupLogon()
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if indexPath.row == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "side_friend_cell")!
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "side_text_cell") as! SideMenuCell
            
            if let menuCell = cell as? SideMenuCell {
                if indexPath.row == 2 {
//                    menuCell.btnCount.isHidden = false
                    
//                    menuCell.btnCount.setTitle("123", for: UIControlState.normal)
//                    menuCell.constCellEventBtnWidth.constant = 33.0
                }
                
                switch indexPath.row {
                case 0:
                    menuCell.lblTitle.text = "예약 내역"
                case 1:
                    menuCell.lblTitle.text = "내 정보"
                case 2:
                    menuCell.lblTitle.text = "이벤트・공지사항"
                default:
                    ()
                }
                
            }
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var bLogon: Bool = true
        if let bLog = uSession.isLogin {
            bLogon = bLog
        }
        
        switch indexPath.row {
        case 0:
            if bLogon {
                guard let ResNavi = self.storyboard?.instantiateViewController(withIdentifier: "ReservationNavi") as? UINavigationController else {
                    return
                }
                
                self.present(ResNavi, animated: true, completion: nil)
                
            } else {
                self.onBtnLogin(self.btnLogin)
            }
        case 1:
            if bLogon {
                
                guard let ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else {
                    return
                }
                
                self.present(ProfileVC, animated: true, completion: nil)
                
            } else {
                self.onBtnLogin(self.btnLogin)
            }
        case 2:
            let sb = UIStoryboard(name: "Notice", bundle: Bundle.main)
            
            guard let NoticeNavi = sb.instantiateViewController(withIdentifier: "NoticeNavi") as? UINavigationController else {
                return
            }
            
            guard let vc = NoticeNavi.topViewController as? NoticeContainVC else {
                return
            }
            
            self.present(NoticeNavi, animated: true, completion: nil)
            
//            self.navigationController?.view.makeToast("Event", duration: 1.0, position: .bottom)
        case 3:
            
            let sb = UIStoryboard(name: "Notice", bundle: Bundle.main)
            
            guard let NoticeNavi = sb.instantiateViewController(withIdentifier: "NoticeNavi") as? UINavigationController else {
                return
            }
            
            guard let vc = NoticeNavi.topViewController as? NoticeContainVC else {
                return
            }
            
            vc.bFriends = true
            
            self.present(NoticeNavi, animated: true, completion: nil)
            
//            self.navigationController?.view.makeToast("Friend", duration: 1.0, position: .bottom)
        default:
            ()
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
