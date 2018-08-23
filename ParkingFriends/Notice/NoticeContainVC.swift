//
//  NoticeContainVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import TabPageViewController

class NoticeContainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initTabPageVC()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Init TabPageVC
    func initTabPageVC() {
        let tabPageVC = TabPageViewController.create()
        
        let sb = UIStoryboard(name: "Notice", bundle: Bundle.main)
        
        guard let vc1 = sb.instantiateViewController(withIdentifier: "NoticeVC") as? NoticeVC else {
            return
        }
        
        guard let vc2 = sb.instantiateViewController(withIdentifier: "NoticeVC") as? NoticeVC else {
            return
        }
        
        
        tabPageVC.tabItems = [(vc1, "이벤트"), (vc2, "공지사항")]
        tabPageVC.option.tabWidth = view.frame.width / CGFloat(tabPageVC.tabItems.count)
        tabPageVC.option.currentColor = hexStringToUIColor(hex: "#000000")
        
        
        
        self.addChildViewController(tabPageVC)
        self.view.addSubview(tabPageVC.view)
        tabPageVC.didMove(toParentViewController: self)
        
    }
    
    
    // MARK: - Btn Action
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
