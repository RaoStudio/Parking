//
//  NoticeVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import WebKit
import MessageUI
import Alamofire

class NoticeVC: UIViewController, WKNavigationDelegate, WKUIDelegate, MFMessageComposeViewControllerDelegate {
    
    

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var constTop: NSLayoutConstraint!
    
    var webView: WKWebView!
    
    var host = UrlStrings.URL_EVENT
    
    var param: String = ""
    
    let uSession = UserSession()
    
    var strEventSid: String = ""
    
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
    
    
    // MARK: - API Call (URL_EVENT_REWARD)
    func requestEventReward() {
        
        let url = UrlStrings.URL_EVENT_REWARD
        
//        let param = ["msid": uSession.sid!, "esid": strEventSid] as [String: Any]
        let param = ["msid": uSession.sid!, "esid": strEventSid] as [String: Any]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_EVENT_REWARD) : \(String(describing: response.result.error))")
                self.alert("\(UrlStrings.URL_EVENT_REWARD) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value as? Dictionary<String, Any> {
                print("requestPartnerContact JSON = \(value)")
                
                if let strStatus = value["status"] as? String {
                    if strStatus == "200" {
                        self.alert("포인트를 지급하였습니다. 감사합니다.") {
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        self.alert("현재 정상적인 처리가 되지 않았습니다. 잠시후 다시 시도해 주세요.")
                    }
                }
            }
        }
        
    }
    
    
    
    // MARK: - MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        print(result.hashValue)
        
        if result == MessageComposeResult.sent {
            self.requestEventReward()
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start")
        self.navigationController?.view.makeToastActivity(.center)
        
        
        if let url = webView.url {
            let strUrl = String(describing: url)
            
            print(strUrl)
            
            if strUrl.contains("mms") {
                
                if uSession.isLogin == true {
                    
                    let arrUrl = strUrl.split(separator: "&")
                    let arrUseSid = arrUrl.first?.split(separator: "=").map { String($0)}
                    
                    if let strSid = arrUseSid?.last {
                        strEventSid = strSid
                    }
                                        
                    
                    let composeVC = MFMessageComposeViewController()
                    composeVC.messageComposeDelegate = self
                    
                    composeVC.recipients = []
                    composeVC.body = "파킹프렌즈 앱 출시!\nIoT 기반 실시간 주차정보를 사용해보세요.\nhttps://parkingfriends.net"
                    
                    if MFMessageComposeViewController.canSendText() {
                        self.present(composeVC, animated: true, completion: nil)
                    }
                } else {
                    let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                    
                    if let loginVC = sb.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                        self.navigationController?.pushViewController(loginVC, animated: true)
                    }
                }
            }
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End")
        self.navigationController?.view.hideToastActivity()
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Fail Navigation")
        self.navigationController?.view.hideToastActivity()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Fail ProvisionalNavigation")
        self.navigationController?.view.hideToastActivity()
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        print("\(String(describing: navigationAction.request.allHTTPHeaderFields))")
        
        decisionHandler(WKNavigationActionPolicy.allow)
        
        print("decidePolicyFor navigationAction")
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
        
        print("decidePolicyFor navigationResponse")
    }
    
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation : \(webView.url!)")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit : \(webView.url!)")
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
