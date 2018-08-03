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
        
        webView = initWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    func initWebView() -> WKWebView {
        
        let config = WKWebViewConfiguration()
        let webView:WKWebView = WKWebView(frame: self.contentsView.frame, configuration: config)
        
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentsView.addSubview(webView)
        
        
        /*
        if #available(iOS 11.0, *) {
            let safeArea = self.view.safeAreaLayoutGuide
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            
        } else {
            
            
        }
 */
        
        webView.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: contentsView.topAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor).isActive = true
        
        let url = NSURL(string: host)
        
        let request = NSURLRequest(url: url! as URL)
        webView.load(request as URLRequest)
        
        
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
