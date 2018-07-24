//
//  PresentTestVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 24..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

protocol PresentExitDelegate {
    func onPresentExit()
}

class PresentTestVC: UIViewController {

    var bTab: Bool = true
    var delegate: PresentExitDelegate?
    
    @IBOutlet var contentsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.alpha = 0
        
        
        if true == bTab {
            let tapG = UITapGestureRecognizer(target: self, action: #selector(tapMainView(_:)))
            self.view.addGestureRecognizer(tapG)
        }
        
        /*
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
        }) { (_) in
            self.view.alpha = 1
        }
 */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
        }) { (_) in
            self.view.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapMainView(_ sender: UIView) {
        
        /* present
        let top = UIApplication.shared.keyWindow
        top?.rootViewController?.addChildViewController(vc)
        top?.addSubview(vc.view)
        vc.didMove(toParentViewController: top?.rootViewController)
         */
        
//        self.presentingViewController?.dismiss(animated: false, completion: nil)
    
        /*
        self.removeFromParentViewController()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0;
        }) { (_) in
            self.view.removeFromSuperview()
        }
 */
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0;
        }) { (_) in
            self.presentingViewController?.dismiss(animated: false, completion: nil)
            
            if let presentDelegate = self.delegate {
                presentDelegate.onPresentExit()
            }
            
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
