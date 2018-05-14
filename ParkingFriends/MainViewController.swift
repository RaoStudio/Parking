//
//  MainViewController.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 3. 26..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import SideMenu

import GoogleMaps
import Alamofire

enum RadiusType: String {
    case fiveH = "500m"
    case oneT = "1Km"
    case fiveT = "5Km"
    case tenT = "10km"
    
    static let allValues = [fiveH, oneT, fiveT, tenT]
}

enum RadiusValue: Int {
    case fiveH = 500
    case oneT = 1000
    case fiveT = 5000
    case tenT = 10000
    
    static let allValues = [fiveH, oneT, fiveT, tenT]
}

class MainViewController: UIViewController {
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var addressLabel: UILabel!
    
    var circle: GMSCircle!
    
    private let locationManager = CLLocationManager()
    
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
    
    var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    
    let uinfo = UserInfoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSideMenu()
//        setupMap()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func loadView() {
    func setupMap() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    
    
    // MARK: - Action
    @IBAction func onBtnRadius(_ sender: UIButton) {
        
        let strRadius = uinfo.radius ?? RadiusType.fiveH.rawValue
        
        let select = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        /*
        let act = UIAlertAction(title: "500m", style: UIAlertActionStyle.default) { (_) in
            
        }
        act.setTextColor(UIColor.red)
        
        select.addAction(act)
         */
        
        //*
        select.addAction(UIAlertAction(title: RadiusType.fiveH.rawValue, style: UIAlertActionStyle.default, handler: { (_) in
            self.radiusPicker(strRadius: RadiusType.fiveH.rawValue)
        }))
        //*/
        
        select.addAction(UIAlertAction(title: RadiusType.oneT.rawValue, style: UIAlertActionStyle.default, handler: { (_) in
            self.radiusPicker(strRadius: RadiusType.oneT.rawValue)
        }))
        select.addAction(UIAlertAction(title: RadiusType.fiveT.rawValue, style: UIAlertActionStyle.default, handler: { (_) in
            self.radiusPicker(strRadius: RadiusType.fiveT.rawValue)
        }))
        select.addAction(UIAlertAction(title: RadiusType.tenT.rawValue, style: UIAlertActionStyle.default, handler: { (_) in
            self.radiusPicker(strRadius: RadiusType.tenT.rawValue)
        }))
        
        select.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        
        for (ix,v) in RadiusType.allValues.enumerated(){
            if strRadius == v.rawValue {
                select.actions[ix].setTextColor(UIColor.red)
            }
        }
        
        
        self.present(select, animated: true, completion: nil)
        
    }
    
    func radiusPicker(strRadius: String) {
        uinfo.radius = strRadius
        
        RefreshParkingLot(self.mapView.camera.target, url: UrlStrings.URL_API_PARKINGLOT_FETCH)
    }
    
    func getIntFromRadius() -> Int {
        let strRadius = uinfo.radius ?? RadiusType.fiveH.rawValue
        
        var nRadius = RadiusValue.fiveH.rawValue
        
        for (ix,v) in RadiusType.allValues.enumerated(){
            if strRadius == v.rawValue {
                nRadius = RadiusValue.allValues[ix].rawValue
            }
        }
        
        return nRadius
    }
    
    
    // MARK: - Side
    fileprivate func setupSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController;
        
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view);
     
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .viewSlideInOut, .menuDissolveIn]
        SideMenuManager.default.menuPresentMode = modes[0]
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
        SideMenuManager.default.menuFadeStatusBar = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            
            self.addressLabel.unlock()
            
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            self.addressLabel.text = lines.joined(separator: "\n")
            
            
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            self.mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: labelHeight, right: 0)
            
            
            UIView.animate(withDuration: 0.25, animations: {
                //        self.pinImageVerticalConstraint.constant = labelHeight * 0.5
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    private func fetchNearbyPlace(coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius: searchRadius, types: searchedTypes) { places in
            places.forEach({ place in
                let marker = PlaceMarker(place: place)
                marker.map = self.mapView
            })
        }
    }
    
    func RefreshParkingLot(_ coordinate: CLLocationCoordinate2D, url: String, bMarkerRemake: Bool = true) {
        
        let strRadius = String(describing: getIntFromRadius())
        
        let param = ["latitude" : coordinate.latitude,
            "longitude" : coordinate.longitude,
            "radius" : strRadius,
            "type" : "15"] as [String : Any]

        
//        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
//        let url = URL(string: UrlStrings.URL_API_PARKINGLOT_FETCH)
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            
            
            
            guard response.result.isSuccess else {
                print("\(url) : \(String(describing: response.result.error))")
                
                self.mapView.clear()
                
                if self.circle != nil {
                    self.circle.position = coordinate
                    self.circle.radius = Double(self.getIntFromRadius())
                    self.circle.map = self.mapView
                }
                
                return
            }
            
            //*
            self.mapView.clear()
            
            if self.circle != nil {
                self.circle.position = coordinate
                self.circle.radius = Double(self.getIntFromRadius())
            }
            //*/
            
            if let value = response.result.value {
                print("RefreshParkingLot JSON = \(value)")
                
                if let arrResponse = response.result.value as? Array<Any> {
                    arrResponse.forEach({ place in
                        //                        let marker = PlaceMarker(place: place as! GooglePlace)
                        //                        marker.map = self.mapView
                        
                        if let dicPlace = place as? Dictionary<String, Any> {
                            
                            let lat: NSString = dicPlace["latitude"] as! NSString
                            let long: NSString = dicPlace["longitude"] as! NSString
                            let partner : NSString = dicPlace["partner"] as! NSString
                            let cctv : NSString = dicPlace["cctv"] as! NSString
                            
                            /*
                             let position = CLLocationCoordinate2D(latitude: 37, longitude: 127)
                             let marker = GMSMarker(position: position)
                             */
                            
                            
                            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat.doubleValue), longitude: CLLocationDegrees(long.doubleValue)))
                            
                            if partner.isEqual(to: "1") {
                                if cctv.isEqual(to: "1") {
                                    marker.icon = UIImage(named: "lot_test_cctv")
                                } else {
                                    marker.icon = UIImage(named: "lot_test")
                                }
                            } else {
                                marker.icon = UIImage(named: "public_lot")
                            }
                            
                            
                            
                            marker.groundAnchor = CGPoint(x: 0.5, y: 1)
                            marker.appearAnimation = GMSMarkerAnimation.pop
                            marker.isTappable = true
                            marker.userData = dicPlace
                            
                            
                            marker.map = self.mapView
                            self.circle.map = self.mapView
                        }
                        
                        }
                    )
                }


                
            }
            
            
        }
        
    }
}


// MARK: - GMSMapViewDelegate
extension MainViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
        
        
        self.mapView.clear()
        
        RefreshParkingLot(position.target, url: UrlStrings.URL_API_PARKINGLOT_FETCH)
        
        //*
        if circle == nil {
            circle = GMSCircle(position: self.mapView.camera.target, radius: Double(getIntFromRadius()))
            //        circle.fillColor = UIColor.redColor().colorWithAlphaComponent(0.5)
            circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.05)
            circle.map = self.mapView
            circle.position = position.target
        } else {
            circle.position = position.target
            circle.radius = Double(getIntFromRadius())
        }
        //*/
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        reverseGeocodeCoordinate(coordinate)
        
        self.mapView.clear()
        
        RefreshParkingLot(coordinate, url: UrlStrings.URL_API_PARKINGLOT_FETCH)
        
        mapView.camera = GMSCameraPosition(target: coordinate, zoom: self.mapView.camera.zoom , bearing: 0, viewingAngle: 0)
        
        if circle == nil {
            circle = GMSCircle(position: self.mapView.camera.target, radius: Double(getIntFromRadius()))
            //        circle.fillColor = UIColor.redColor().colorWithAlphaComponent(0.5)
            circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.05)
            circle.map = self.mapView
            circle.position = coordinate
        } else {
            circle.position = coordinate
            circle.radius = Double(getIntFromRadius())
        }
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        addressLabel.lock()
        
        if (gesture) {
//            mapCenterPinImage.fadeIn(0.25)
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let placeMarker = marker as? PlaceMarker else {
            return nil
        }
        
        guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
            return nil
        }
        
        infoView.nameLabel.text = placeMarker.place.name
        
        if let photo = placeMarker.place.photo {
            infoView.placePhoto.image = photo
        } else {
            infoView.placePhoto.image = UIImage(named: "generic")
        }
        
        return infoView
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        mapCenterPinImage.fadeOut(0.25)
        
        //*
        let detailNavi = self.storyboard?.instantiateViewController(withIdentifier: "DetailNavi") as? UINavigationController;
        
        let detailVC = detailNavi?.topViewController as? DetailVC
        
        detailVC?.dicPlace = marker.userData as? Dictionary<String, Any>
        
        self.present(detailNavi!, animated: true, completion: nil)
         //*/
        
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//        mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        return false
    }
}

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    
    /*
     *  locationManager:didChangeAuthorizationStatus:
     *
     *  Discussion:
     *    Invoked when the authorization status changes for this application.
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == CLAuthorizationStatus.authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    /*
     *  locationManager:didUpdateLocations:
     *
     *  Discussion:
     *    Invoked when new locations are available.  Required for delivery of
     *    deferred locations.  If implemented, updates will
     *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
     *
     *    locations is an array of CLLocation objects in chronological order.
     */
    @available(iOS 6.0, *)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        if Platform.isSimulator {
            let testLocation = CLLocationCoordinate2D(latitude: 37.4823511, longitude: 127.0036083)
            mapView.camera = GMSCameraPosition(target: testLocation, zoom: 15, bearing: 0, viewingAngle: 0)
        } else {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        }
        
        locationManager.stopUpdatingLocation()
        
//        fetchNearbyPlace(coordinate: location.coordinate)
        
        /*
        circle = GMSCircle(position: self.mapView.camera.target, radius: 1000)
        //        circle.fillColor = UIColor.redColor().colorWithAlphaComponent(0.5)
        circle.fillColor = UIColor.red
        circle.map = self.mapView
 */
    }
    
}
