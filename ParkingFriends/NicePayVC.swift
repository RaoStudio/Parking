//
//  NicePayVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 2..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import WebKit

class NicePayVC: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("##userContentController")
        print(message)
        print("##userContentController")
    }
    

    @IBOutlet weak var contentsView: UIView!
    
    var webView: WKWebView!
//    var webView: UIWebView!
    
//    var host = "http://m.daum.net"
//    var host = "http://api.parkingfriends.net/app/payment/unipay.php"
    var host = UrlStrings.URL_API_NICEPAY_REQUEST
   
   
    // Test Param
//    var param = "PayMethod=CELLPHONE&BuyerName=%EB%AF%B8%EB%9E%98%EC%97%94%EC%94%A8%ED%8B%B0&BuyerTel=01036638266&BuyerEmail=misconct6161%40gmail.com&member_sid=8&parkinglot_sid=7874&reserve_type=R&begin=2018-08-03+11%3A20&end=2018-08-03+13%3A20&price_ori=5000&point=0&type=nice_etc&code=3RYF9V32S7UULZTNMV1GITB9"
    
    
//    PayMethod=CELLPHONE&BuyerName=%EB%AF%B8%EB%9E%98%EC%97%94%EC%94%A8%ED%8B%B0&BuyerTel=01036638266&BuyerEmail=misconct6161%40gmail.com&member_sid=8&parkinglot_sid=7874&reserve_type=R&begin=2018-08-03+17%3A20&end=2018-08-03+19%3A20&price_ori=5000&point=0&type=nice_etc&code=3RYF9V32S7UULZTNMV1GITB9
    
//    var param = "PayMethod=CELLPHONE&BuyerName=미래엔씨티&BuyerTel=01036638266&BuyerEmail=misconct6161@gmail.com&member_sid=8&parkinglot_sid=7874&reserve_type=R&begin=2018-08-03 17:20&end=2018-08-03 19:20&price_ori=5000&point=0&type=nice_etc&code=3RYF9V32S7UULZTNMV1GITB9"
    
    var param: String = ""
 
    var bCard: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        webView = initWebView()
        initWebView()
        
        self.navigationItem.title = "결제"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        webView = initWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
//    func initWebView() -> UIWebView {
//    func initWebView() -> WKWebView {
    func initWebView() {
    
        
        
        
        let config = WKWebViewConfiguration()
        
        // Add 2018.08.29
        let contentController = WKUserContentController();
        contentController.add(self, name:"document.getElementsByClassName('wrapper')[0].innerHTML;")
        config.userContentController = contentController
        // Add 2018.08.29
        
        
//        let webView:WKWebView = WKWebView(frame: .zero, configuration: config)
        webView = WKWebView(frame: .zero, configuration: config)
        
        self.contentsView.addSubview(webView)
        
//        let webView = UIWebView(frame: .zero)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
//        webView.allowsBackForwardNavigationGestures = true
        
        
//        self.contentsView.addSubview(webView)
        
        
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
        
        /*
        if #available(iOS 11.0, *) {
            webView.load(request as URLRequest)
        }
        else {
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, respense: URLResponse?, error: Error?) in
                if data != nil {
                    if let returnString = String(data: data!, encoding: .utf8) {
                        webView.loadHTMLString(returnString, baseURL: url! as URL)
//                        webView.loadHTMLString(returnString, baseURL: nil)
                    }
                    
                }
            }
            task.resume()
        }
    */
        
//        webView.loadRequest(request)
        
        
        
//        return webView
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start")
        
        
        if let url = webView.url {
            let strUrl = String(describing: url)
            if strUrl.contains("navigate") {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NaviVC") else {
                    return
                }
                
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false, completion: nil)
                
            } else if strUrl.contains("payment_done") {
             
                /*
                if let top = UIApplication.shared.keyWindow {
                    if let navi = top.rootViewController as? UINavigationController {
                        
                        if let arrVC = navi.viewControllers as? [UIViewController] {
                            navi.popViewController(animated: true)
                        }
                    }
                }
                */
                
                
//                self.navigationController?.popViewController(animated: true)
//                self.navigationController?.popToRootViewController(animated: true)
                
                
                webView.evaluateJavaScript("document.getElementsByClassName('wrapper')[0].innerHTML;") { (result, error) in
                    if error != nil {
                        print("###Start###")
                        print(result)
                        print("###Start###")
                    } else {
                        print("###Start###")
                        print(result)
                        print("###Start###")
                    }
                }
                
                
                
                
                if let arrVC = self.navigationController?.viewControllers {
                 
                    for vc in arrVC {
                        if let pVC = vc as? PaymentVC {
                            pVC.onBtnExit(UIBarButtonItem())
                        }
                    }
                }
                
            }
            //*
            else if strUrl.contains("kakaotalk") {
                
//                let arrStr = strUrl.components(separatedBy: "=")
//                let kUrl = URL(string: arrStr.last!)
//                var request = URLRequest(url: kUrl!)
//                request.httpMethod = "GET"
//                webView.load(request)
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            //*/
            else if strUrl.contains("itunes.apple.com") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        
        webView.evaluateJavaScript("document.getElementsByClassName('wrapper')[0].innerHTML;") { (result, error) in
            if error != nil {
                print("###Start###")
                print(result)
                print("###Start###")
            } else {
                print("###Start###")
                print(result)
                print("###Start###")
            }
        }
        
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End")
        
        /*
        webView.evaluateJavaScript("document.getElementById('wrapper').innerText") { (result, error) in
            if error != nil {
                print(result)
            }
        }
        */
        webView.evaluateJavaScript("document.getElementsByClassName('wrapper')[0].innerHTML;") { (result, error) in
            if error != nil {
                print("###End###")
                print(result)
                print("###End###")
            } else {
                print("###End###")
                print(result)
                print("###End###")
            }
        }
        
        
        webView.evaluateJavaScript("document.cookie") { (object, error) in
            if let string: String = object as? String {
//                Devg.createFile("COOKIE", contents: string)
                print("###End Cookie###")
                print(object)
                print("###End Cookie###")
            }
        }
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Fail Navigation")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Fail ProvisionalNavigation")
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        print("\(String(describing: navigationAction.request.allHTTPHeaderFields))")
        /*
        let accessToken = "Bearer 527d3401f16a8a7955aeae62299dbfbd"
        var request = navigationAction.request
        
        if !(request.allHTTPHeaderFields?.keys.contains("Authorization"))! {
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
            decisionHandler(WKNavigationActionPolicy.cancel)
            self.webView.load(request)
        } else {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
 */
        
        decisionHandler(WKNavigationActionPolicy.allow)
        
        
        /*
        if let url = navigationAction.request.url, url.scheme != "http" && url.scheme != "https" {
//            UIApplication.shared.openURL(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
        */
    }
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
        
        print(navigationResponse)
        
        
    }
 
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation : \(webView.url!)")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(webView.url!)
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
