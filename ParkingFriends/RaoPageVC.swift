//
//  RaoPageVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 8..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class RaoPageVC: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in view.subviews {
            if subView is UIPageControl {
                if let pageControl = subView as? UIPageControl {
                    
//                    pageControl.frame.origin.y = self.view.frame.size.height - 100
//                    pageControl.frame.origin.y = pageControl.frame.origin.y - pageControl.frame.size.height
                    pageControl.backgroundColor = UIColor.clear
                    pageControl.pageIndicatorTintColor = UIColor.lightGray
                    pageControl.currentPageIndicatorTintColor = UIColor.green
                    pageControl.hidesForSinglePage = true
                    self.view.bringSubview(toFront: pageControl)
                }
            }
            

            if subView is UIScrollView {
                if let scrollView = subView as? UIScrollView {
                    scrollView.frame.size.height = self.view.frame.size.height                    
                }
            }
        }
        
//        self.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
     //*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
