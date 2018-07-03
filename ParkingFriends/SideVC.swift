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
    @IBOutlet weak var lblCellTitle: UILabel!
    @IBOutlet weak var btnCellEventCount: UIButton!
    
    
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
        
        if let bLogin = uSession.isLogin, bLogin == true, bFirstLogon == true {
            //            self.updateProfile()
            //            bFirstLogon = false
            
            lblName.text = uSession.name
            lblPoint.text = String(format: "%d P", uSession.point!)
            lblEmail.text = uSession.email
            lblCar.text = uSession.carName
            
            if let strPhoto = uSession.photoUrl, false == strPhoto.isEmpty {
                self.ivThumb.sd_setImage(with: URL(string: strPhoto), placeholderImage: UIImage(named: "Side_pf_logo"))
            }
            
        } else {
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - API
    func updateProfile() {
        let url = UrlStrings.URL_API_USER_GET
        Alamofire.request(url).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("\(url) : \(String(describing: response.result.error))")
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
    }
    
    @IBAction func onBtnFaq(_ sender: UIButton) {
    }
    
    @IBAction func onBtnQuestion(_ sender: UIButton) {
    }
    
    
    @IBAction func onBtnTest(_ sender: Any) {
        guard let RegisterNavi = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? UINavigationController else {
            return
        }
        
        self.present(RegisterNavi, animated: true, completion: nil)
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
            cell = tableView.dequeueReusableCell(withIdentifier: "side_text_cell")! as! SideMenuCell
            
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
