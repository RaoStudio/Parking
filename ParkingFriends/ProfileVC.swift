//
//  ProfileVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDataSource, UITableViewDelegate, RegisterBtnDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ivThumb: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    let uSession = UserSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.ivThumb.layer.cornerRadius = self.ivThumb.frame.width/2
        self.ivThumb.layer.masksToBounds = true
        
        //*
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //*/
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let strName = uSession.name {
            lblName.text = strName
        }
        
        if let strEmail = uSession.email {
            lblEmail.text = strEmail
        }
        
        if let strPhoto = uSession.photoUrl, false == strPhoto.isEmpty {
            self.ivThumb.sd_setImage(with: URL(string: strPhoto), placeholderImage: UIImage(named: "Profile_Thumb"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Btn Action
    @IBAction func onBtnLogout(_ sender: UIButton) {
        self.uSession.initUserSession()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnExit(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func onRegisterBtn(at index: IndexPath) {
        if index.row == 1 {
            tableView(self.tableView, didSelectRowAt: index)
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        let nRow = indexPath.row
        
        
        if nRow == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextCell")!
            if let textCell = cell as? ProfileTextCell {
                textCell.lbl_Title.text = "휴대폰 번호"
                textCell.lbl_Contents.text = uSession.mobile
            }
        } else if nRow == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileBtnCell")!
            if let btnCell = cell as? ProfileBtnCell {
                btnCell.lbl_Title.text = "차량정보"
                btnCell.lbl_Contents.text = uSession.getCarInfo()
                btnCell.delegate = self
                btnCell.indexPath = indexPath
                
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextCell")!
            if let textCell = cell as? ProfileTextCell {
                textCell.lbl_Title.text = "포인트"
                
                if let nPoint = uSession.point {
                    let strPoint = String(format: "%d", nPoint)
                    textCell.lbl_Contents.text = "\(strPoint.decimalPresent) P"
                }
                
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 62.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        if indexPath.row == 1 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CarInfoRegisterVC") as? CarInfoRegisterVC else {
                return
            }
            vc.bTab = false
            
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion: nil)
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
