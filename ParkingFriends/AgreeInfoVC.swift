//
//  AgreeInfoVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 26..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class AgreeInfoVC: UIViewController {

    @IBOutlet weak var txtContentsView: UITextView!
    
    var nTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        txtContentsView.text = ""
        
        /*
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        let attributes = [NSParagraphStyleAttributeName : style]
        txtContentsView.attributedText = NSAttributedString(string: txtString, attributes: attributes)
         */
        
        
        
        
        guard let path = Bundle.main.path(forResource: "InfoDataList", ofType: "plist"), let myDict = NSDictionary(contentsOfFile: path) else {
            return
        }
        
        
        if let arrInfo = myDict.value(forKey: "AgreeInfoData") as? Array<NSDictionary>  {
            if let dicInfo: NSDictionary = arrInfo[nTag] {
                if let strContents = dicInfo.value(forKey: "contents") as? String, let strTitle = dicInfo.value(forKey: "title") as? String {
//                    self.alert(strContents)
                    
                    self.navigationItem.title = strTitle
                    self.txtContentsView.text = strContents
                    
                    
                    //*
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 10
                    let attributes = [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.light)]
//                    let attrFont = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.light)]
//                    txtContentsView.attributedText = NSAttributedString(string: txtContentsView.text, attributes: attrFont)
                    txtContentsView.attributedText = NSAttributedString(string: txtContentsView.text, attributes: attributes)
                    //*/
                }
                
            }
        }
        
        
        let contentHeight = txtContentsView.contentSize.height
        let offSet = txtContentsView.contentOffset.x
        let contentOffset = contentHeight - offSet
        txtContentsView.contentOffset = CGPoint(x: 0, y: -contentOffset)
        
        
        
        
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
