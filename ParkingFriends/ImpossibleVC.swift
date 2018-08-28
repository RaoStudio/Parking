//
//  ImpossibleVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 28..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ImpossibleVC: PresentTestVC {

    @IBOutlet weak var txtImpossible: UITextView!
    
    var strImpossible: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtImpossible.text = strImpossible
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Btn Action
    
    @IBAction func onBtnOk(_ sender: UIButton) {
        self.tapMainView(self.view)
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
