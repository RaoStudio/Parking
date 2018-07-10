//
//  LotListVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 9..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import GoogleMaps

class LotListVC: UITableViewController {

    var arrPlace = [GMSMarker]()
    var bDistance = true
    
    var arrDisplay = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        if true == bDistance {
            arrDisplay = arrPlace.sorted(by: { (first: GMSMarker, second: GMSMarker) -> Bool in
                let dic = first.userData as? Dictionary<String, Any>
                let dic2 = second.userData as? Dictionary<String, Any>
                let one = dic!["distance"] as! Double
                let two = dic2!["distance"] as! Double
                
                return one < two
            })
        } else {
            arrDisplay = arrPlace.sorted(by: { (first: GMSMarker, second: GMSMarker) -> Bool in
                let dic = first.userData as? Dictionary<String, Any>
                let dic2 = second.userData as? Dictionary<String, Any>
                let one = dic!["default_fees"] as! String
                let two = dic2!["default_fees"] as! String
                
                return Int(one)! < Int(two)!
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrDisplay.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        /*
        let nSection = indexPath.section
        let nRow = indexPath.row
         */
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ParkingLotCell")!
        
            
        
        if let pCell = cell as? ParkingLotCell {
            
            // Configure the cell...
            if let dic = arrDisplay[indexPath.row].userData as? Dictionary<String, Any> {
                
                pCell.lbl_available.text = dic["available"] as? String
                pCell.lbl_capacity.text = String(format: "%@ 면", (dic["capacity"] as? String)!)
                
                pCell.lbl_company.text = dic["company"] as? String
                pCell.lbl_address.text = dic["address"] as? String
                
                let strDistance: String
                let distance = dic["distance"] as? Double ?? 0
                if distance > 1000 {
                    strDistance = String(format: "%.2fkm", distance/1000)
                } else {
                    strDistance = String(format: "%.0fm", distance)
                }
                
                /*
                 "default_minute": "60",
                 "default_fees": "5000",
                 */
                
                let strPay = String(format: "%@분/%@원", (dic["default_minute"] as? String)!, (dic["default_fees"] as? String)!)
                
                
                
                if true == bDistance {
                    pCell.lbl_trans1.text = strDistance
                    pCell.lbl_trans2.text = strPay
                } else {
                    pCell.lbl_trans1.text = strPay
                    pCell.lbl_trans2.text = strDistance
                }
            }
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89.0
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
