//
//  ParkingLotVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 16..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import TabPageViewController
import GoogleMaps

class ParkingLotVC: UIViewController {

    var arrPlace = [GMSMarker]()
    @IBOutlet weak var viewGradient: RaoGradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        self.navigationItem.title = "주차장목록"
        self.tabBarItem.title = "거리순"
        
        //*
        let tabPageVC = TabPageViewController.create()
        
//        let vc1 = UIViewController()
        
        let sb = UIStoryboard(name: "ParkingLot", bundle: Bundle.main)
        
        guard let vc1 = sb.instantiateViewController(withIdentifier: "ParkingLotDetailVC") as? ParkingLotDetailVC else {
            return
        }
        
        guard let vc2 = sb.instantiateViewController(withIdentifier: "ParkingLotDetailVC") as? ParkingLotDetailVC else {
            return
        }

        vc1.bDistance = true
        vc1.arrPlace = self.arrPlace
        
        vc1.view.backgroundColor = UIColor.white
        
        
//        let vc2 = UIViewController()
        
        
        vc2.bDistance = false
        vc2.arrPlace = self.arrPlace
        vc2.view.backgroundColor = UIColor.white
        
        tabPageVC.tabItems = [(vc1, "거리순"), (vc2, "요금순")]
        tabPageVC.option.tabWidth = view.frame.width / CGFloat(tabPageVC.tabItems.count)

        tabPageVC.option.currentColor = hexStringToUIColor(hex: "#000000")
        tabPageVC.option.tabHeight = 40
        
        
        
//        tabPageVC.option.hidesTopViewOnSwipeType = .all
        
//        self.navigationController?.pushViewController(tabPageVC, animated: true)
 
        
        
        
        self.addChildViewController(tabPageVC)
        self.view.addSubview(tabPageVC.view)
        tabPageVC.didMove(toParentViewController: self)
        //*/
        
        
//        self.view.bringSubview(toFront: self.viewGradient)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBtnExit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
