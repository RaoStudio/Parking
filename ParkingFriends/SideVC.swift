//
//  SideVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 25..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class SideVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var constLogout: NSLayoutConstraint!     // orig 187
    @IBOutlet weak var constLogin: NSLayoutConstraint!      // orig 173
    
    
    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblCar: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCellTitle: UILabel!
    @IBOutlet weak var btnCellEventCount: UIButton!
    
    
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "side_text_cell")!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
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
