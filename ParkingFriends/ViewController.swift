//
//  ViewController.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 3. 5..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Commit Test ~ @@ ~
        setupSideMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    fileprivate func setupSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController;
        
        //        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view);
        
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .viewSlideInOut, .menuDissolveIn]
        SideMenuManager.default.menuPresentMode = modes[0]
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
    }
}

