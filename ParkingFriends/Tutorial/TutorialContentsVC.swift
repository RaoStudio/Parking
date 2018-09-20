//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by MyoungHyoun Cho on 2018. 3. 21..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import SDWebImage

class TutorialContentsVC: UIViewController {

    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        if imageFile.contains(UrlStrings.URL_API_PARKINGLOT_IMG) {
            self.bgImageView.sd_setImage(with: URL(string: self.imageFile), placeholderImage: UIImage(named: "Detail_NoImage"))
        } else {
            self.bgImageView.image = UIImage(named: self.imageFile)
            self.bgImageView.contentMode = .scaleAspectFit
            
            if imageFile == "Public_Lot_Image" {
                self.bgImageView.contentMode = .scaleToFill
            }
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
