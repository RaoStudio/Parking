//
//  FaqVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import WebKit

class FaqVC: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var contentsView: UIView!
    
    
    var webView: WKWebView!
    
    var host = UrlStrings.URL_FAQ
    
    var param: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func initWebView() {
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        
        self.contentsView.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: contentsView.topAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor).isActive = true
        
        let url = NSURL(string: host)
        
        var request = URLRequest(url: url! as URL)
        let paramData = param.data(using: .utf8)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        
        
        webView.load(request as URLRequest)
    }
    
    // MARK: - Btn Action
    @IBAction func onBtnFaq(_ sender: UIBarButtonItem) {
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
