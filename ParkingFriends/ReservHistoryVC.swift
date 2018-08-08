//
//  ReservHistoryVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 8..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire

class ReservHistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var arrData = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        requestFetchReservationHistory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Btn Action
    @IBAction func onBtnExit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - API ( URL_API_RESERVATION_FETCH_HISTORY )
    func requestFetchReservationHistory() {
        let param = ["reserve_type" : "ALL"] as [String: Any]
        
        Alamofire.request(UrlStrings.URL_API_RESERVATION_FETCH_HISTORY, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_API_RESERVATION_FETCH_HISTORY) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value {
                print("requestFetchReservationHistory JSON = \(value)")
                
                self.arrData = value as! [Dictionary<String, Any>]
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ReservHistoryCell")!
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
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
