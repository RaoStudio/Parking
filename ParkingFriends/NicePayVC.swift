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
    
//    var host = "http://m.daum.net"
    var host = UrlStrings.URL_API_NICEPAY_REQUEST
   
   
    var param = "PayMethod=CELLPHONE&BuyerName=%EB%AF%B8%EB%9E%98%EC%97%94%EC%94%A8%ED%8B%B0&BuyerTel=01036638266&BuyerEmail=misconct6161%40gmail.com&member_sid=8&parkinglot_sid=7874&reserve_type=R&begin=2018-08-03+11%3A20&end=2018-08-03+13%3A20&price_ori=5000&point=0&type=nice_etc&code=3RYF9V32S7UULZTNMV1GITB9"
 
    
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
        
        var request = URLRequest(url: url! as URL)
        let paramData = param.data(using: .utf8)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        
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
