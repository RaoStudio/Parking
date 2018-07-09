//
//  CSTabBarController.swift
//  Chapter03-CSTabBar
//
//  Created by MyoungHyoun Cho on 2018. 3. 5..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class CSTabBarController: UITabBarController {

    let csView = UIView()
    
    let tabItem01 = UIButton(type: UIButtonType.system)
    let tabItem02 = UIButton(type: UIButtonType.system)
    let tabItem03 = UIButton(type: UIButtonType.system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBar.isHidden = true
        
        let width = self.view.frame.width
        let height: CGFloat = 50
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = UIColor.brown
        
        self.view.addSubview(csView)
        
        
        let tabBtnWidth = self.csView.frame.size.width / 3
        let tabBtnHeight = self.csView.frame.size.height
        
        self.tabItem01.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem02.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem03.frame = CGRect(x: tabBtnWidth * 2, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        
        self.addTabBarBtn(btn: self.tabItem01, title: "1", tag: 0)
        self.addTabBarBtn(btn: self.tabItem02, title: "2", tag: 1)
        self.addTabBarBtn(btn: self.tabItem03, title: "3", tag: 2)
        
        self.onTabBarItemClick(self.tabItem01)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTabBarBtn(btn: UIButton, title: String, tag: Int) {
        btn.setTitle(title, for: UIControlState.normal)
        btn.tag = tag
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.yellow, for: .selected)
        
        btn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: UIControlEvents.touchUpInside)
        
        self.csView.addSubview(btn)
    }
    
    @objc func onTabBarItemClick(_ sender: UIButton) {
        self.tabItem01.isSelected = false
        self.tabItem02.isSelected = false
        self.tabItem03.isSelected = false
        
        sender.isSelected = true
        
        self.selectedIndex = sender.tag
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
