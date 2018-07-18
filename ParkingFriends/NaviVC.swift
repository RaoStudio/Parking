//
//  NaviVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 16..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import CoreLocation

class NaviVC: PresentTestVC, TMapTapiDelegate {

    let uinfo = UserInfoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        TMapTapi.setSKPMapAuthenticationWith(self, apiKey:"3f936e4b-cbea-4c51-8411-f20659ac8a4f");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Btn Action
    
    
    @IBAction func onBtnKakao(_ sender: UIButton) {
        // 목적지 길안내 - 카카오판교오피스 - 전체 경로정보 보기
//        let destination = KNVLocation(name: "카카오판교오피스", x: 127.1087, y: 37.40206)
        let destination = KNVLocation(name: uinfo.rCompany ?? "", x: NSNumber(value: uinfo.rLongtitude ?? 0), y: NSNumber(value: uinfo.rLatitude ?? 0))
        let options = KNVOptions()
        options.coordType = KNVCoordType.WGS84
        options.routeInfo = true
        let params = KNVParams(destination: destination, options: options)
        KNVNaviLauncher.shared().navigate(with: params) { (error) in
            self.handleError(error: error)
        }
        
//        tapMainView(self.view)
    }
    
    
    @IBAction func onBtnTmap(_ sender: UIButton) {
        
        var bTmap:Bool = TMapTapi.isTmapApplicationInstalled()
        
        TMapTapi.setSKPMapAuthenticationWith(self, apiKey:"3f936e4b-cbea-4c51-8411-f20659ac8a4f");
        
        if bTmap == true {
            /*
//            TMapTapi.setSKPMapAuthenticationWith(self, apiKey: "3f936e4b-cbea-4c51-8411-f20659ac8a4f");
//            let destDrdX:Double = 126.958535225971;
//            let destDrdY:Double = 37.4865233562417;
//            let destAddr:String = "서울 관악구 관악로30길 13";
 */
            
            let destDrdX:Double = uinfo.rLatitude ?? 0;
            let destDrdY:Double = uinfo.rLongtitude ?? 0;
            let destAddr:String = uinfo.rCompany ?? "";
            
            let coordinate = CLLocationCoordinate2D(latitude: destDrdX, longitude: destDrdY);
            TMapTapi.invokeRoute(destAddr, coordinate: coordinate);
        } else {
            
            
            if let strUrl = TMapTapi.getTMapDownUrl() {
                if let url = URL(string: strUrl) {
                    if UIApplication.shared.canOpenURL(url) {
                        
                        self.showAlert(toastTitle: "AppStore", toastMsg: "TMap 어플설치를 위해 AppStore로 이동하시겠습니까?", positiveBtn: true, negativeBtn: true, done_action: {
                        
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }) {
//                            self.tapMainView(self.view)
                        }
                        
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            
        }
        
    }
    
    
    @IBAction func onBtnOneNavi(_ sender: UIButton) {
        
        // ollehnavi://kt.navi/?method=routeguide&end=("+latitude+","+longitude+")
//        let strUrl = String(format: "ollehnavi://kt.navi/?method=routeguide&end=(\"%f\",\"%f\")", uinfo.rLatitude ?? 0, uinfo.rLongtitude ?? 0)
        let strUrl = String(format: "ollehnavi://")
        print(strUrl)
        
        if let url = URL(string: strUrl) {
            if UIApplication.shared.canOpenURL(url) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                self.showAlert(toastTitle: "AppStore", toastMsg: "원내비 어플설치를 위해 AppStore로 이동하시겠습니까?", positiveBtn: true, negativeBtn: true, done_action: {
                    
                    UIApplication.shared.open(URL(string: "https://itunes.apple.com/kr/app/id390369834")!, options: [:], completionHandler: nil)
                }) {
                    
                }
            }
        }
        
    }
    
    
    
    func handleError(error: Error?) -> Void {
        if let error = error as NSError? {
            print(error)
            let alert = UIAlertController(title: self.title!, message: error.localizedFailureReason, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
