//
//  ParkingLotDetailVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 10..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import GoogleMaps
import TabPageViewController

class ParkingLotDetailVC: UIViewController {
    
    var arrPlace = [GMSMarker]()
    var bDistance = true
    
    var arrDisplay = [GMSMarker]()
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

//        self.navigationController?.view.makeToastActivity(.center)
        
        //*
        if true == bDistance {
            arrDisplay = arrPlace.sorted(by: { (first: GMSMarker, second: GMSMarker) -> Bool in
                let dic = first.userData as? Dictionary<String, Any>
                let dic2 = second.userData as? Dictionary<String, Any>
                let one = dic!["distance"] as! Double
                let two = dic2!["distance"] as! Double
                
                return one < two
            })
            
            self.tabBarItem.title = "거리순"
        } else {
            arrDisplay = arrPlace.sorted(by: { (first: GMSMarker, second: GMSMarker) -> Bool in
                let dic = first.userData as? Dictionary<String, Any>
                let dic2 = second.userData as? Dictionary<String, Any>
                let one = dic!["default_fees"] as! String
                let two = dic2!["default_fees"] as! String
                
                return Int(one)! < Int(two)!
            })
            
            self.tabBarItem.title = "요금순"
        }
 //*/
        
        
        if iOS_VERSION_LESS_THAN_OR_EQUAL_TO(version: "10.3.3") {
            self.edgesForExtendedLayout = []
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.scrollToBottom(animated: true)
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        if arrDisplay.isEmpty == true {
            
            if true == bDistance {
                arrDisplay = arrPlace.sorted(by: { (first: GMSMarker, second: GMSMarker) -> Bool in
                    let dic = first.userData as? Dictionary<String, Any>
                    let dic2 = second.userData as? Dictionary<String, Any>
                    let one = dic!["distance"] as! Double
                    let two = dic2!["distance"] as! Double
                    
                    return one < two
                })
                
                self.tabBarItem.title = "거리순"
            } else {
                arrDisplay = arrPlace.sorted(by: { (first: GMSMarker, second: GMSMarker) -> Bool in
                    let dic = first.userData as? Dictionary<String, Any>
                    let dic2 = second.userData as? Dictionary<String, Any>
                    let one = dic!["default_fees"] as! String
                    let two = dic2!["default_fees"] as! String
                    
                    return Int(one)! < Int(two)!
                })
                
                self.tabBarItem.title = "요금순"
            }
        }
 */
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        if let navi = self.presentingViewController as? UINavigationController {
            if let vc = navi.topViewController as? MainViewController {
                vc.hideToastActivity()
            }
        }
        
        
        if iOS_VERSION_LESS_THAN_OR_EQUAL_TO(version: "10.3.3") {
            
            let navigationHeight = topLayoutGuide.length
            tableView.contentInset.top = navigationHeight - TabPageOption().tabHeight
            tableView.contentInset.top = 0.0
            self.edgesForExtendedLayout = []
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /*
        if let pVC = self.parent as? ParkingLotVC {
            let arrVC = pVC.childViewControllers
            
            for vc in arrVC {
                if vc is TabPageViewController {
                    let navigationHeight = topLayoutGuide.length
                    tableView.contentInset.top = navigationHeight + TabPageOption().tabHeight
                }
            }
            
        }
         */
        
        /*
        let navigationHeight = topLayoutGuide.length
        tableView.contentInset.top = navigationHeight + TabPageOption().tabHeight
 */
        
        if iOS_VERSION_LESS_THAN_OR_EQUAL_TO(version: "10.3.3") {
        
            let navigationHeight = topLayoutGuide.length
            tableView.contentInset.top = navigationHeight - TabPageOption().tabHeight
            tableView.contentInset.top = 0.0
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension ParkingLotDetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrDisplay.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        /*
         let nSection = indexPath.section
         let nRow = indexPath.row
         */
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ParkingLotCell")!
        
        
        
        if let pCell = cell as? ParkingLotCell {
            
            // Configure the cell...
            if let dic = arrDisplay[indexPath.row].userData as? Dictionary<String, Any> {
                
                /*
                 let str = "img"+String(i)
                 if let img: String = dataPlace[str] as? String, false == img.isEmpty {
                 contentImages.append(UrlStrings.URL_API_PARKINGLOT_IMG + (img as String))
                 }
                 self.bgImageView.sd_setImage(with: URL(string: self.imageFile), placeholderImage: UIImage(named: "Detail_NoImage"))
                 */
                
                if let img: String = dic["img1"] as? String, false == img.isEmpty {
                    let strImg: String = UrlStrings.URL_API_PARKINGLOT_IMG + img
                    
                    pCell.ivThumb.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: "List_NoImage"))
                } else {
                    pCell.ivThumb.image = UIImage(named: "List_NoImage")
                }
                
                
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
                
                //                let strPay = String(format: "%@분/%@원", (dic["default_minute"] as? String)!, (dic["default_fees"] as? String)!)
                let strPay = String(format: "%@원", dic["default_fees"] as! String)
                
                
                
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let navi = self.presentingViewController as? UINavigationController {
            if let vc = navi.topViewController as? MainViewController {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
                vc.mapView(vc.mapView , didTap: self.arrDisplay[indexPath.row])
                if let dic = arrDisplay[indexPath.row].userData as? Dictionary<String, Any> {
                    if let lat = dic["latitude"] as? String, let long = dic["longitude"] as? String {
                        vc.mapViewPositon(coordinate: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!))
                    }
                }
                
                
                
                
//                vc.mapView(vc.mapView, idleAt: GMSCameraPosition)
                
//                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
