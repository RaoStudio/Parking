//
//  NicePayVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 2..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import WebKit

class NicePayVC: UIViewController {

    @IBOutlet weak var contentsView: UIView!
    var webView: WKWebView?
    var host = "http://m.daum.net"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.webView = initWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initWebView() -> WKWebView {
        
        let config = WKWebViewConfiguration()
        
        let webView:WKWebView = WKWebView(frame: self.contentsView.frame, configuration: config)
        let url = NSURL(string: host)
        
        let request = NSURLRequest(url: url! as URL)
        webView.load(request as URLRequest)
        self.contentsView.addSubview(webView)
        
        return webView
        
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
