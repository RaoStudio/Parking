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
import GooglePlaces
import Alamofire
import PureLayout

import DropDown
import SwiftDate

/*
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
 */

class MainViewController: UIViewController {
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var btnRadius: RoundButton!
    
    
    @IBOutlet var btnStart: UIButton!
    @IBOutlet var btnEnd: UIButton!
    @IBOutlet weak var btnTimeInit: UIButton!
    
    
    @IBOutlet var btnLocation: RoundButton!
    
    
    
    @IBOutlet var constLotWidth: NSLayoutConstraint!
    @IBOutlet var constLotHeight: NSLayoutConstraint!
    @IBOutlet var constLocationWidth: NSLayoutConstraint!
    @IBOutlet var constLocationHeight: NSLayoutConstraint!
    @IBOutlet var constRadiusWidth: NSLayoutConstraint!
    @IBOutlet var constRadiusHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewEndTimeSelect: UIView!
    @IBOutlet weak var btnEndTime: UIButton!
    
    
    
    var circle: GMSCircle!
    
    private let locationManager = CLLocationManager()
    
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
    
    var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    
    let uinfo = UserInfoManager()
    
    var strRadius: String = ""
    
    var bTime: Bool = false
    var bStart: Bool = true
    var bDestination: Bool = false
    var destCoordinate: CLLocationCoordinate2D?
    var myCoordinate: CLLocationCoordinate2D?
    
    // Google Sample
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    // Google Sample
    
    
    
    let chooseDropDown = DropDown()
    let endTimeDropDown = DropDown()
    
    
    
    let bUseDropDown = false
    
    
    var bLocation: Bool = true
    
//    var arrPlace = [Dictionary<String, Any>]()
    var arrPlace = [GMSMarker]()
    
    var arrPublicPlace = [GMSMarker]()
    var arrPartnerPlace = [GMSMarker]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSideMenu()
//        setupMap()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        strRadius = uinfo.radius ?? RadiusType.fiveH.rawValue
        
        btnRadius.setTitle(uinfo.radius ?? RadiusType.fiveH.rawValue, for: UIControlState.normal)
        
     
        // Google Sample
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
//        resultsViewController?.primaryTextHighlightColor = UIColor.green
        resultsViewController?.primaryTextHighlightColor = hexStringToUIColor(hex: "#00ff00")
        
        
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        /*
        let defaultTextAttribs = [NSAttributedStringKey.font.rawValue: UIFont.boldSystemFont(ofSize: 15.0), NSAttributedStringKey.foregroundColor.rawValue:UIColor.red]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = defaultTextAttribs
        */
        
        searchController?.searchBar.placeholder = "어느 지역의 주차장을 찾고 계신가요 ?"
        
        

        /*
        let myAttribute = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]
        let attrString = NSAttributedString(string: "어느 지역의 주차장을 찾고 계신가요?", attributes: myAttribute)
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = attrString
        let txtF = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        txtF.attributedPlaceholder = attrString
        */
        
        
        /*
        let searchBarTextAttributes: [String : AnyObject] = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.red, NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        UITextField.appearance(whenContainedInInstancesOf:[UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
         */
        
        
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).placeholder = "Test"
        
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
        // Google Sample
        
        
        // Objective - C
        /*
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil]
            setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
         */
        
        if bUseDropDown {
            setupChooseDropDown()
        }
        
        
        
        
        
        /*
        let height = UIScreen.main.nativeBounds.height
        
        if height >= 1920 {
            
            constLotWidth.constant = 45
            constLotHeight.constant = 45
            
            constLocationWidth.constant = 45
            constLocationHeight.constant = 45
            
            constRadiusWidth.constant = 70
            constRadiusHeight.constant = 32
        }
        */
        
        
        // Time Set
        /*
        let nowDate = Date()
        var nowDatePlus10 = nowDate + 10.minute
        
        let min10 = (nowDatePlus10.minute / 10) * 10
        
        nowDatePlus10 = nowDatePlus10 - nowDatePlus10.minute.minute + min10.minute
        
        let dateAfterNow = Date(timeInterval: 60*60, since: nowDatePlus10)
        let strNowDate = uinfo.dateToString(nowDatePlus10)
        let strDateAfterNow = uinfo.dateToString(dateAfterNow)
        
        uinfo.startTime = strNowDate
        uinfo.endTime = strDateAfterNow
         */
        
        
        uinfo.initTime()
        
        uinfo.initTimePickerVCTime()      // Add new init timePickerVC 
        
        displayTimeToButton()
        
        
        setupEndTimeDropDown()
        
//        btnStart.setTitle(uinfo.startTime, for: UIControlState.normal)
//        btnEnd.setTitle(uinfo.endTime, for: UIControlState.normal)
        
        
        
        /*
        let calendar = Calendar(identifier: .gregorian)
        let date = uinfo.stringToDate(strNowDate)
        let wd = calendar.dateComponents([.weekday], from: date)
         */
        
//        let strDay = uinfo.dayFromDate(strNowDate)
        
        
        
        guard let LaunchVC = self.storyboard?.instantiateViewController(withIdentifier: "LaunchVC") as?  LaunchVC else {
            return
        }
        
        LaunchVC.willMove(toParentViewController: self)
        self.addChildViewController(LaunchVC)
        self.view.addSubview(LaunchVC.view)
        LaunchVC.didMove(toParentViewController: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false && bStart {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: false, completion: nil)
            bStart = false
        }
        */
        
        
        displayTimeToButton()
        
        /*
        if let selIndex = endTimeDropDown.indexForSelectedRow {
            print("@@@@@\(selIndex)@@@@@")
        }
        */
        
        
        self.navigationController?.view.hideToastActivity()
        
        if let strUinfoRadius = uinfo.radius {
            if strRadius != strUinfoRadius {
                strRadius = strUinfoRadius
                btnRadius.setTitle(strRadius, for: UIControlState.normal)
                radiusPicker(strRadius: strRadius)
            }
        }
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false && bStart {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: false, completion: nil)
            bStart = false
        }
        */
        
        if let selIndex = endTimeDropDown.indexForSelectedRow {
            print("@@@@@\(selIndex)@@@@@")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear")
        
//        searchController?.searchBar.resignFirstResponder()
        
        /*
        if (searchController?.searchBar.isFirstResponder)! {
            self.wasCancelled(GMSAutocompleteViewController())
        }
 */
        
        if let bFirest = searchController?.searchBar.isFirstResponder {
            if bFirest == true {
                self.wasCancelled(GMSAutocompleteViewController())
            }
        }
    }
    
    func launchTutorial() {
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false && bStart {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: true, completion: nil)
            bStart = false
        }
    }
    
    func hideToastActivity() {
        self.navigationController?.view.hideToastActivity()
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
    
    
    // MARK: - Setup DropDown
    func setupChooseDropDown() {
        chooseDropDown.anchorView = self.btnRadius
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        chooseDropDown.topOffset = CGPoint(x: 0, y: -self.btnRadius.bounds.height)
        
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseDropDown.dataSource = [
            RadiusType.fiveH.rawValue,
            RadiusType.oneT.rawValue,
            RadiusType.fiveT.rawValue,
            RadiusType.tenT.rawValue
        ]
        
        chooseDropDown.direction = .top
        // Action triggered on selection
        chooseDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnRadius.setTitle(item, for: .normal)
            self?.radiusPicker(strRadius: item)
        }
    }
    
    func setupEndTimeDropDown() {
        endTimeDropDown.textFont = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        endTimeDropDown.textColor = UIColor.white
        endTimeDropDown.backgroundColor = hexStringToUIColor(hex: "#13b6f7")
        endTimeDropDown.selectionBackgroundColor = hexStringToUIColor(hex: "#13c1ff")
        endTimeDropDown.cellHeight = 49.0
        
        endTimeDropDown.bottomOffset = CGPoint(x: 0, y: self.viewEndTimeSelect.bounds.height)
        endTimeDropDown.anchorView = self.viewEndTimeSelect
        
        var arrData: Array = [String]()
        
        for item in EndTimeType.allValues {
            arrData.append(item.rawValue)
        }
        
        endTimeDropDown.dataSource = arrData
        endTimeDropDown.selectRow(uinfo.nIndexEnd!)
        
        endTimeDropDown.direction = .bottom
        
        
        self.btnEndTime.setTitle(arrData.first, for: UIControlState.normal)
        
        endTimeDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .center
        }
        
        endTimeDropDown.selectionAction = { [weak self] (index, item) in
            if self?.btnEndTime.title(for: UIControlState.normal) == item {
                return
            }
            
            self?.btnEndTime.setTitle(item, for: UIControlState.normal)
            
//            let endHours = EndTimeValue.allValues[index].rawValue.hours
            let endHours = EndTimeValue.allValues[index].rawValue
            self?.uinfo.endHours = endHours
            
            let endDate = (self?.uinfo.stringToDate((self?.uinfo.startTime!)!))! + endHours.hours
            self?.uinfo.endTime = self?.uinfo.dateToString(endDate)
            
            self?.uinfo.nIndexEnd = index
            
            print(self?.uinfo.startTime)
            print(self?.uinfo.endTime)
            print("\n")
            
            self?.reserveFromTimePick()
            
        }
        
    }
    
    
    // MARK: - Action
    
    @IBAction func onBtnQuestion(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainQuestionVC") as? MainQuestionVC else {
            return
        }
        
        vc.bTab = false
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    @IBAction func onBtnLocation(_ sender: UIButton) {
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        
        mapView.selectedMarker = nil
        destCoordinate = nil
        
        searchController?.searchBar.text = ""
        
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: self.mapView.camera.zoom)
        
        self.mapView.animate(to: camera)
        
        btnLocation.isSelected = false
        bLocation = true
    }
    
    
    @IBAction func onBtnParkingLot(_ sender: Any) {
        let sb = UIStoryboard(name: "ParkingLot", bundle: Bundle.main)
        //*
        guard let ParkingLotNavi = sb.instantiateViewController(withIdentifier: "ParkingLotNavi") as? UINavigationController else {
            return
        }
        
        
        guard let vc = ParkingLotNavi.topViewController as? ParkingLotVC else {
            return
        }
        
        self.navigationController?.view.makeToastActivity(.center)
        
        vc.arrPlace = self.arrPlace
        
        self.present(ParkingLotNavi, animated: true, completion: nil)
        
        //*/
        
        
        /*
        guard let vc = sb.instantiateViewController(withIdentifier: "ParkingLotTabBar") as? UITabBarController else {
            return
        }
 
        vc.navigationItem.title = "주변 주차장 목록"
        
        if let tbItems = vc.tabBar.items {
            tbItems[1].title = "요금순"
        }
        
        if let listVC = vc.viewControllers?.last as? LotListVC {
            listVC.bDistance = false
            listVC.arrPlace = self.arrPlace
        }
         
        
         self.navigationController?.pushViewController(vc, animated: true)
        */

        
        
    }
    
    
    @IBAction func onBtnStartTimePicker(_ sender: UIButton) {
        guard let timePickerNavi = self.storyboard?.instantiateViewController(withIdentifier: "StartTimePickerNavi") as? UINavigationController else {
            return
        }
        
        //        let timePickerVC = timePickerNavi.topViewController as? TimePickerVC
        self.present(timePickerNavi, animated: true, completion: nil)
    }
    
    
    @IBAction func onBtnTimePicker(_ sender: Any) {
        
        guard let timePickerNavi = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerNavi") as? UINavigationController else {
            return
        }
        
//        let timePickerVC = timePickerNavi.topViewController as? TimePickerVC
        self.present(timePickerNavi, animated: true, completion: nil)
        
        
        
        /*
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerVC") as? TimePickerVC else {
            return
        }
        
        self.present(vc, animated: true, completion: nil)
         */
    }
    
    
    @IBAction func onBtnSubViewTest(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentTestVC") else {
            return
        }
        /*
        let top = UIApplication.shared.keyWindow
        top?.rootViewController?.addChildViewController(vc)
        top?.addSubview(vc.view)
        vc.didMove(toParentViewController: top?.rootViewController)
 */
        let top = UIApplication.shared.keyWindow
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
//        top?.rootViewController?.present(vc, animated: false, completion: nil)
        
        
//        self.present(vc, animated: false, completion: nil)
        
        
//        self.view.addSubviewWithConstraints(RaoBaseView(), offset: false)
//        let view = RaoBaseView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
 
        /*
        let top = UIApplication.shared.keyWindow
        let view = RaoBaseView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        top?.addSubview(view)
        view.autoPinEdgesToSuperviewEdges()
         */
        
        /*
        let nibs = Bundle.main.loadNibNamed("TestView", owner: self, options: nil)
        if let view = nibs?.first as? UIView {
            //            view.backgroundColor = UIColor.red
            view.translatesAutoresizingMaskIntoConstraints = false
            let top = UIApplication.shared.keyWindow
            top?.addSubview(view)
            
            view.autoPinEdgesToSuperviewEdges()
        }
        */
        
        /*
        let top = UIApplication.shared.keyWindow
        let view = CustomView(frame: (top?.bounds)!)
        top?.addSubview(view)
         */
        
        
        
    }
    
    
    @IBAction func onBtnEndTime(_ sender: UIButton) {
        endTimeDropDown.show()
    }
    
    
    @IBAction func onBtnRadius(_ sender: UIButton) {
        
        if bUseDropDown {
            chooseDropDown.show()
            return;
        }
        
        
        
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
            self.radiusPicker(strRadius: RadiusType.fiveH.rawValue, sender: sender)
        }))
        //*/
        
        select.addAction(UIAlertAction(title: RadiusType.oneT.rawValue, style: UIAlertActionStyle.default, handler: { (_) in
            self.radiusPicker(strRadius: RadiusType.oneT.rawValue, sender: sender)
        }))
        select.addAction(UIAlertAction(title: RadiusType.fiveT.rawValue, style: UIAlertActionStyle.default, handler: { (_) in
            self.radiusPicker(strRadius: RadiusType.fiveT.rawValue, sender: sender)
        }))
        select.addAction(UIAlertAction(title: RadiusType.tenT.rawValue, style: UIAlertActionStyle.default, handler: { (_) in
            self.radiusPicker(strRadius: RadiusType.tenT.rawValue, sender: sender)
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
    
    func radiusPicker(strRadius: String, sender: UIButton? = nil) {
//    func radiusPicker(strRadius: String) {
        uinfo.radius = strRadius
        
        sender?.setTitle(strRadius, for: UIControlState.normal)
        
        RefreshParkingLot(self.mapView.camera.target, url: UrlStrings.URL_API_PARKINGLOT_FETCH, bTime: self.bTime)
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
    
    
    func reserveFromTimePick() {

//        self.bTime = true     // for version 2
        
//        btnStart.setTitle(uinfo.startTime, for: UIControlState.normal)
//        btnEnd.setTitle(uinfo.endTime, for: UIControlState.normal)
        
        displayTimeToButton()
        
        btnTimeInit.setTitle("처음으로 되돌리기", for: UIControlState.normal)
        
        RefreshParkingLot(self.mapView.camera.target, url: UrlStrings.URL_API_PARKINGLOT_FETCH_RATIO, bTime: self.bTime)
    }
    
    
    @IBAction func onBtnTimeInit(_ sender: UIButton) {
        if self.bTime {
            uinfo.initTime()
            uinfo.initTimePickerVCTime()      // Add new init timePickerVC 
            
            self.bTime = false
            
//            btnStart.setTitle(uinfo.startTime, for: UIControlState.normal)
//            btnEnd.setTitle(uinfo.endTime, for: UIControlState.normal)
            displayTimeToButton()
            
            btnTimeInit.setTitle("주차시간으로 검색하기", for: UIControlState.normal)
            RefreshParkingLot(self.mapView.camera.target, url: UrlStrings.URL_API_PARKINGLOT_FETCH_RATIO, bTime: self.bTime)
        }
    }
    
    
    func displayTimeToButton() {
        let startDate = uinfo.stringToDate(uinfo.startTime!)
        let endDate = uinfo.stringToDate(uinfo.endTime!)
        
        let strNow = String(format: "%02d/%02d일 %@ %02d:%02d", startDate.month, startDate.day, startDate.weekdayName, startDate.hour, startDate.minute)
        let strEnd = String(format: "%02d/%02d일 %@ %02d:%02d", endDate.month, endDate.day, endDate.weekdayName, endDate.hour, endDate.minute)
        
        
        btnStart.setTitle(strNow, for: UIControlState.normal)
        btnEnd.setTitle(strEnd, for: UIControlState.normal)
        
        print("@@@@@@\(startDate.weekday)")
//        lblDate.text = String(format: "%02d/%02d %@", startDate.month, startDate.day, startDate.weekdayShortName)
        lblDate.text = String(format: "%02d/%02d %@", startDate.month, startDate.day, DayNameType.allValues[startDate.weekday-1].rawValue)
        lblTime.text = String(format: "%02d:%02d", startDate.hour, startDate.minute)
        
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
     
        let appWindowRect = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
        
//        SideMenuManager.default.menuWidth = min(round(min((appWindowRect.width), (appWindowRect.height)) * 0.87), 279)
        SideMenuManager.default.menuWidth = min(round(min((appWindowRect.width), (appWindowRect.height)) * 0.87), 326)
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
    
    // MARK: - InstanceFromNib
    func instanceFromNib(strNib: String) -> UIView {
        return UINib(nibName: strNib, bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    // MARK: - Calculate
    func calcPrice(dicPlace : Dictionary<String, Any>) -> String? {
        
        if let strMin = dicPlace["default_minute"] as? String, let strFee = dicPlace["default_fees"] as? String
            , let strAddMin = dicPlace["additional_minute"] as? String, let strAddFee = dicPlace["additional_fees"] as? String
        {
            let startDate = uinfo.stringToDate(uinfo.startTime!)
            let endDate = uinfo.stringToDate(uinfo.endTime!)
            
            let nTime = endDate - startDate
            
            let nDefaultMin = Int(strMin)!
            let nDefaultFee = Int(strFee)!
            
            let nAddMin = Int(strAddMin)!
            let nAddFee = Int(strAddFee)!
            
            
            // Calc Total Pay
            var nTotalPay: Int = nDefaultFee
            let nTotalMin = Int(nTime) / 60
            let nRestMin = nTotalMin - nDefaultMin
            
            if nAddMin > 0 {
                let nTimeMultiply = nRestMin / nAddMin
                let nTimeMultiplyRest = nRestMin % nAddMin
                nTotalPay = nTotalPay + nAddFee * nTimeMultiply
                if nTimeMultiplyRest > 0 {
                    nTotalPay = nTotalPay + nAddFee
                }
            }
            
            return String(format: "%d", nTotalPay)
        }
        
        return nil
    }
    
    func isBetweenOperationTime(dicPlace: Dictionary<String, Any>) -> Bool {
        var strWeek: String = ""
        let startDate = uinfo.stringToDate(uinfo.startTime!)
        let endDate = uinfo.stringToDate(uinfo.endTime!)
        
        print("##Today is \(endDate.weekdayName)  \(endDate)")
        print("##Start is \(uinfo.dateToString(startDate))")
        print("##End is \(uinfo.dateToString(endDate))")
        
        if endDate.isInWeekend {
            strWeek = "operationtime_holiday"
        } else {
            strWeek = "operationtime_week"
        }
        
        /*
        if let strOperationTime = dicPlace[strWeek] as? String {
            print("##Operation Time is \(strOperationTime)")
        } else {
            return false
        }
        */
        
        guard let strOperation = dicPlace[strWeek] as? String else {
            return false
        }
        
        let arrStr = strOperation.split(separator: "~").map { (strTime) -> String in
            return String(strTime)
        }
        
        print(arrStr)
        
        if let strStart = arrStr.first, let strEnd = arrStr.last {
            print(strStart)
            print(strEnd)
            
            
            let fOpStartHour = Int(strStart[0..<2])!
            let fOpStartMin = Int(strStart[2..<strStart.count])!
            
            var fOpEndHour = Int(strEnd[0..<2])!
            let fOpEndMin = Int(strEnd[2..<strEnd.count])!
            
            if fOpEndHour == 00 {
                fOpEndHour = 24
            }
            
            let calendar = Calendar.current
            let date = calendar.date(from: calendar.dateComponents(in: TimeZone.current, from: endDate))
            print(date)
            print("##OriginalDate is \(uinfo.dateToString(date!))\n")
            
            
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date!)
            components.hour = fOpStartHour
            components.minute = fOpStartMin
//            components.second = 0
            
            let opStartDate = calendar.date(from: components)
            
            
            components.hour = fOpEndHour
            components.minute = fOpEndMin
//            components.second = 0
            
            var opEndDate = calendar.date(from: components)
            
            
            if (fOpStartHour > fOpEndHour) {
                opEndDate = opEndDate! + 24.hour
            }
            
//            let transDate = calendar.date(bySetting: .hour, value: fOpStartHour, of: date!)
            
            print(opStartDate)
            print("##trans opStartDate is \(uinfo.dateToString(opStartDate!))\n")
            print(opEndDate)
            print("##trans opEndDate is \(uinfo.dateToString(opEndDate!))\n")
            
            let opAvailStartDate = opStartDate! - 1.seconds
            print("##Avail StartDate is \(opAvailStartDate)")
            print("##Avail StartDate is \(uinfo.dateToString(opAvailStartDate))\n")
            
            let opAvailEndDate = opEndDate! + 1.seconds
            print("##Avail EndDate is \(opAvailEndDate)")
            print("##Avail EndDate is \(uinfo.dateToString(opAvailEndDate))\n")
            
            let bStartEnable = startDate.isBetween(date: opAvailStartDate, and: opAvailEndDate)
            let bEndEnable = endDate.isBetween(date: opAvailStartDate, and: opAvailEndDate)
            
            print("##StartEnable is \(bStartEnable)")
            print("##EndEnable is \(bEndEnable)\n")
            print("##Result is \(bStartEnable && bEndEnable)\n")
            
            return bStartEnable && bEndEnable
            
        }
        
        return false
    }
    
    
    // MARK: - PF API
    func RefreshParkingLot(_ coordinate: CLLocationCoordinate2D, url: String, bDest: Bool = false, bMarkerRemake: Bool = true, bTime: Bool = false) {
        var strRadius = String(describing: getIntFromRadius())
        
        let radius = self.mapView.getRadius()
        print("## Radius : \(radius)##")
        
        strRadius = String(format: "%.0f", radius)
        print("## strRadius : \(strRadius)##")
        
//        let strRadius = "2000"
        let param: Parameters
        var url: String
        
        if bTime {
            url = UrlStrings.URL_API_PARKINGLOT_FETCH_RATIO
            param = ["latitude" : coordinate.latitude,
                     "longitude" : coordinate.longitude,
                     "radius" : strRadius,
                     "begin" : uinfo.startTime!,
                     "end" : uinfo.endTime!] as [String : Any]
            
        } else {
            url = UrlStrings.URL_API_PARKINGLOT_FETCH
            param = ["latitude" : coordinate.latitude,
                     "longitude" : coordinate.longitude,
                     "radius" : strRadius,
                     "type" : "15"] as [String : Any]
        }
        
//        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
//        let url = URL(string: UrlStrings.URL_API_PARKINGLOT_FETCH)
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            self.arrPlace.removeAll()
            
                
            guard response.result.isSuccess else {
                print("\(url) : \(String(describing: response.result.error))")
                self.alert("\(url) : \(String(describing: response.result.error))")
                
                self.mapView.clear()
                
                if self.circle != nil {
                    self.circle.position = coordinate
                    self.circle.radius = Double(self.getIntFromRadius())
//                    self.circle.map = self.mapView
                }
                return
            }
            
            //*
            self.mapView.clear()
            
            if self.circle != nil {
                self.circle.position = coordinate
                self.circle.radius = Double(self.getIntFromRadius())
//                self.circle.map = self.mapView
            }
            //*/
            
            /*
            if bDest {
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                marker.icon = UIImage(named: "destination")
                marker.groundAnchor = CGPoint(x: 0.5, y: 1)
                marker.appearAnimation = GMSMarkerAnimation.pop
                marker.isTappable = true
                marker.map = self.mapView
            }
            */
            
            if let destCoord = self.destCoordinate {
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: destCoord.latitude, longitude: destCoord.longitude))
                marker.icon = UIImage(named: "destination")
                marker.groundAnchor = CGPoint(x: 0.5, y: 1)
//                marker.isTappable = true
                marker.map = self.mapView
                marker.title = "목적지"
                self.mapView.selectedMarker = marker
                /*
                marker.title = "목적지"
                marker.snippet = "Snip Test"
                self.mapView.selectedMarker = marker
                 */
            }
            
            
            if let value = response.result.value {
                print("RefreshParkingLot JSON = \(value)")
                if let arrResponse = response.result.value as? Array<Any> {
                    arrResponse.forEach({ place in
                        //                        let marker = PlaceMarker(place: place as! GooglePlace)
                        //                        marker.map = self.mapView
                        if var dicPlace = place as? Dictionary<String, Any> {
                            
                            let lat: NSString = dicPlace["latitude"] as! NSString
                            let long: NSString = dicPlace["longitude"] as! NSString
                            let partner : NSString = dicPlace["partner"] as! NSString
                            let cctv: NSString = dicPlace["cctv"] as! NSString
                            let available: NSString = dicPlace["available"] as! NSString
                            
                            
                            let nPartner: Int = Int(partner.intValue)
                            let nCCTV: Int = Int(cctv.intValue)
                            
                            /*
                             let position = CLLocationCoordinate2D(latitude: 37, longitude: 127)
                             let marker = GMSMarker(position: position)
                             */
                            
                            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat.doubleValue), longitude: CLLocationDegrees(long.doubleValue)))
                            
                            if nPartner == 1 {
                                //                            if partner.isEqual(to: "1") {
                                //                                if cctv.isEqual(to: "1") {
                                if nCCTV > 0 {
                                    if available.isEqual(to: "0") {
                                        marker.icon = UIImage(named: "partner_lot_cctv_full")
                                    } else {
                                        marker.icon = UIImage(named: "partner_lot_cctv")
                                    }
                                } else {
                                    if available.isEqual(to: "0") {
                                        marker.icon = UIImage(named: "partner_lot_full")
                                    } else {
                                        marker.icon = UIImage(named: "partner_lot")
                                    }
                                }
                            } else {
//                                marker.icon = UIImage(named: "public_lot")
                                let view = PublicView.instanceFromNib()
//                                let strPrice = dicPlace["default_fees"] as! String
                                
                                if let strPrice = self.calcPrice(dicPlace: dicPlace) {
                                    view.setPrice(strPrice: strPrice)
                                }
                                
//                                view.setPrice(strPrice: strPrice)
                                
                                marker.iconView = view
                                
                                let nowDate = Date()
//                                let calendar = Calendar(identifier:  .gregorian)
                                let calendar = Calendar.current
//                                let date = calendar.date(from: DateComponents(year: 2016, month:  10, day: 11))
                                let date = calendar.date(from: calendar.dateComponents(in: TimeZone.current, from: nowDate))
                                // -> Oct 11, 2016, 12:00 AM
                                
                                
                                print(date!)
                            }
                            
                            let markerLocation = CLLocation.init(latitude: lat.doubleValue, longitude: long.doubleValue)
                            var originLocation: CLLocation?
                            if self.destCoordinate != nil {
                                originLocation = CLLocation(latitude: (self.destCoordinate?.latitude)!, longitude: (self.destCoordinate?.longitude)!)
                            } else {
                                originLocation = CLLocation(latitude: (self.myCoordinate?.latitude)!, longitude: (self.myCoordinate?.longitude)!)
                            }
                            
                            dicPlace["distance"] = markerLocation.distance(from: originLocation!)
                            
                            marker.groundAnchor = CGPoint(x: 0.5, y: 1)
                            marker.appearAnimation = GMSMarkerAnimation.pop
                            marker.isTappable = true
                            marker.userData = dicPlace
                            
                            
                            marker.map = self.mapView
//                            self.circle.map = self.mapView
                            
                            //                            self.arrPlace.append(dicPlace)
                            self.arrPlace.append(marker)
                        }
                        }
                    )
                    
                    self.RefreshPartnerParkingLot(coordinate, url: UrlStrings.URL_API_PARKINGLOT_FETCH_RATIO, bTime: true)
                } else if let dicResponse = response.result.value as? Dictionary <String, Any> {
                    print("##DicResponse")
                    print(dicResponse)
                    print("##DicResponse")
   
                    
                    let marker = GMSMarker(position: coordinate)
//                    marker.icon = UIImage(named: "Main_Many_Count")
                    
//                    let view = UINib(nibName: "ManyLotView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ManyLotView
                    let view = ManyLotView.instanceFromNib()
                    view.lblCount.text = dicResponse["count"] as? String
                    
                    marker.iconView = view
                    
                    
                    
                    marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                    marker.appearAnimation = GMSMarkerAnimation.pop
                    marker.isTappable = false
                    marker.map = self.mapView
                    
                    
                    
                    /*
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainManyCountVC") as? MainManyCountVC else {
                        return
                    }
                    
                    vc.strCount = dicResponse["count"] as! String
                    
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: false, completion: nil)
 */
                }
            }
        }
        
    }
    
    func RefreshPartnerParkingLot(_ coordinate: CLLocationCoordinate2D, url: String, bDest: Bool = false, bMarkerRemake: Bool = true, bTime: Bool = true) {
//        let strRadius = String(describing: getIntFromRadius())
        
        var strRadius = String(describing: getIntFromRadius())
        
        let radius = self.mapView.getRadius()
        print("## Radius : \(radius)##")
        
        strRadius = String(format: "%.0f", radius)
        print("## strRadius : \(strRadius)##")
        
        
        let param: Parameters
        var url: String
        
        if bTime {
            url = UrlStrings.URL_API_PARKINGLOT_FETCH_RATIO
            param = ["latitude" : coordinate.latitude,
                     "longitude" : coordinate.longitude,
                     "radius" : strRadius,
                     "begin" : uinfo.startTime!,
                     "end" : uinfo.endTime!] as [String : Any]
            
        } else {
            url = UrlStrings.URL_API_PARKINGLOT_FETCH
            param = ["latitude" : coordinate.latitude,
                     "longitude" : coordinate.longitude,
                     "radius" : strRadius,
                     "type" : "15"] as [String : Any]
        }
        
        //        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        //        let url = URL(string: UrlStrings.URL_API_PARKINGLOT_FETCH)
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
//            self.arrPlace.removeAll()
            
            guard response.result.isSuccess else {
                print("\(url) : \(String(describing: response.result.error))")
                self.alert("\(url) : \(String(describing: response.result.error))")
                
                self.mapView.clear()
                
                if self.circle != nil {
                    self.circle.position = coordinate
                    self.circle.radius = Double(self.getIntFromRadius())
//                    self.circle.map = self.mapView
                }
                return
            }
            
            //*
//            self.mapView.clear()
            
            if self.circle != nil {
                self.circle.position = coordinate
                self.circle.radius = Double(self.getIntFromRadius())
//                self.circle.map = self.mapView
            }
            //*/
            
            if let destCoord = self.destCoordinate {
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: destCoord.latitude, longitude: destCoord.longitude))
                marker.icon = UIImage(named: "destination")
                marker.groundAnchor = CGPoint(x: 0.5, y: 1)
                //                marker.isTappable = true
                marker.map = self.mapView
                marker.title = "목적지"
                self.mapView.selectedMarker = marker
                /*
                 marker.title = "목적지"
                 marker.snippet = "Snip Test"
                 self.mapView.selectedMarker = marker
                 */
            }
            
            
            if let value = response.result.value {
                print("RefreshParkingLot JSON = \(value)")
                
                if let arrResponse = response.result.value as? Array<Any> {
                    arrResponse.forEach({ place in
                        //                        let marker = PlaceMarker(place: place as! GooglePlace)
                        //                        marker.map = self.mapView
                        
                        if var dicPlace = place as? Dictionary<String, Any> {
                            
                            let lat: NSString = dicPlace["latitude"] as! NSString
                            let long: NSString = dicPlace["longitude"] as! NSString
                            let partner : NSString = dicPlace["partner"] as! NSString
                            let cctv: NSString = dicPlace["cctv"] as! NSString
                            let available: NSString = dicPlace["available"] as! NSString
                            let type: NSString = dicPlace["parkinglot_type"] as! NSString
                            
                            let nAvailability: Int  = dicPlace["availability"] as! Int
                            
                            let nPartner: Int = Int(partner.intValue)
                            let nCCTV: Int = Int(cctv.intValue)
                            
                            
                            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat.doubleValue), longitude: CLLocationDegrees(long.doubleValue)))
                            
                            if nPartner == 1 {
                                /*
                                if nCCTV > 0 {
                                    if available.isEqual(to: "0") {
                                        marker.icon = UIImage(named: "partner_lot_cctv_full")
                                    } else {
                                        marker.icon = UIImage(named: "partner_lot_cctv")
                                    }
                                } else {
                                    if available.isEqual(to: "0") {
                                        marker.icon = UIImage(named: "partner_lot_full")
                                    } else {
                                        marker.icon = UIImage(named: "partner_lot")
                                    }
                                }
                                */
                                
                                /*
                                let bAvail = self.isBetweenOperationTime(dicPlace: dicPlace)
                                dicPlace["bAvailOpTime"] = bAvail
                                */
                                
                                let bAvail = self.uinfo.isBetweenOperationTime(dicPlace: dicPlace)
                                dicPlace["bAvailOpTime"] = bAvail
                                
                                
                                
                                
                                
                                if type.isEqual(to: "16") {
                                    let view = ResidentView.instanceFromNib()
                                    if let strPrice = self.calcPrice(dicPlace: dicPlace) {
                                        view.setMarkerView(strPrice: strPrice, bAvailable: nAvailability.boolValue && bAvail)
                                    }
                                    
                                    marker.iconView = view
                                } else {
                                    let view = PartnerView.instanceFromNib()
                                    if let strPrice = self.calcPrice(dicPlace: dicPlace) {
                                        view.setMarkerView(strPrice: strPrice, bAvailable: nAvailability.boolValue && bAvail)
                                    }
                                    
                                    marker.iconView = view
                                }
                                
                                
                                
                            } else {
                                marker.icon = UIImage(named: "public_lot")
                            }
                            
                            let markerLocation = CLLocation.init(latitude: lat.doubleValue, longitude: long.doubleValue)
                            var originLocation: CLLocation?
                            if self.destCoordinate != nil {
                                originLocation = CLLocation(latitude: (self.destCoordinate?.latitude)!, longitude: (self.destCoordinate?.longitude)!)
                            } else {
                                originLocation = CLLocation(latitude: (self.myCoordinate?.latitude)!, longitude: (self.myCoordinate?.longitude)!)
                            }
                            
                            dicPlace["distance"] = markerLocation.distance(from: originLocation!)
                            
                            marker.groundAnchor = CGPoint(x: 0.5, y: 1)
                            marker.appearAnimation = GMSMarkerAnimation.pop
                            marker.isTappable = true
                            marker.userData = dicPlace
                            
                            
                            marker.map = self.mapView
//                            self.circle.map = self.mapView
                            
                            //                            self.arrPlace.append(dicPlace)
                            self.arrPlace.append(marker)
                        }
                        }
                    )
                } else if let dicResponse = response.result.value as? Dictionary <String, Any> {
                    print("##DicResponse Partner")
                    print(dicResponse)
                    print("##DicResponse Partner")
                    
                    let marker = GMSMarker(position: coordinate)
                    let view = ManyLotView.instanceFromNib()
                    view.lblCount.text = dicResponse["count"] as? String
                    
                    marker.iconView = view
                    
                    
                    marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                    marker.appearAnimation = GMSMarkerAnimation.pop
                    marker.isTappable = false
                    marker.map = self.mapView
                    
                }
                
            }
        }
    }
    
    
    // MARK: - Call API Func ~ @@
    func mapViewPositon(coordinate: CLLocationCoordinate2D, bDest: Bool = false) {
        reverseGeocodeCoordinate(coordinate)
        
//        self.mapView.clear()
        
        /*
        var coordi: CLLocationCoordinate2D
        
        if destCoordinate != nil {
            coordi = destCoordinate!
        } else {
            coordi = myCoordinate!
        }
        
        var coordinate = coordi
        */
        
        
        
//        RefreshParkingLot(coordinate, url: UrlStrings.URL_API_PARKINGLOT_FETCH_RATIO, bDest: bDest)
        RefreshParkingLot(coordinate, url: UrlStrings.URL_API_PARKINGLOT_FETCH, bDest: bDest, bTime: self.bTime)
        
        mapView.camera = GMSCameraPosition(target: coordinate, zoom: self.mapView.camera.zoom , bearing: 0, viewingAngle: 0)
        
        if circle == nil {
            circle = GMSCircle(position: self.mapView.camera.target, radius: Double(getIntFromRadius()))
            //        circle.fillColor = UIColor.redColor().colorWithAlphaComponent(0.5)
            circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.05)
            circle.strokeColor = UIColor.green
            circle.strokeWidth = 0.8
//            circle.map = self.mapView
            circle.position = coordinate
        } else {
            circle.position = coordinate
            circle.radius = Double(getIntFromRadius())
        }
    }
}


// MARK: - GMSMapViewDelegate
extension MainViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        self.mapViewPositon(coordinate: position.target)
        
        
        //*
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        
        let posCamera = position.target
        
        if posCamera.latitude.isEqual(to: lat) && posCamera.longitude.isEqual(to: lng) {
            btnLocation.isSelected = false
        } else {
            btnLocation.isSelected = true
        }
        //*/
        
        
        if bLocation == true {
            btnLocation.isSelected = false
            bLocation = false
        } else {
            btnLocation.isSelected = true
        }
        
        
        /*
        reverseGeocodeCoordinate(position.target)
        
//        self.mapView.clear()
        
        RefreshParkingLot(position.target, url: UrlStrings.URL_API_PARKINGLOT_FETCH)
        
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
        */
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        destCoordinate = coordinate
        self.mapViewPositon(coordinate: coordinate)
        /*
        reverseGeocodeCoordinate(coordinate)
        
//        self.mapView.clear()
        
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
         */
    }
    
    
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        addressLabel.lock()
        
        if (gesture) {
//            mapCenterPinImage.fadeIn(0.25)
//            mapView.selectedMarker = nil
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
        
        if nil == marker.userData {
            return false
        }
        
        //*
        let detailNavi = self.storyboard?.instantiateViewController(withIdentifier: "DetailNavi") as? UINavigationController;
        
        let detailVC = detailNavi?.topViewController as? DetailVC
        
        detailVC?.dicPlace = marker.userData as? Dictionary<String, Any>
        
        var strCompany: String = ""
        
        if let dicPlace = marker.userData as? Dictionary<String, Any> {
            if let latitude = dicPlace["latitude"] as? NSString {
                if let longitude = dicPlace["longitude"] as? NSString {
                    
                    let markerLocation = CLLocation.init(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
                    var originLocation: CLLocation?
                    if destCoordinate != nil {
                        originLocation = CLLocation(latitude: (destCoordinate?.latitude)!, longitude: (destCoordinate?.longitude)!)
                    } else {
                        originLocation = CLLocation(latitude: (myCoordinate?.latitude)!, longitude: (myCoordinate?.longitude)!)
                    }
                    detailVC?.distance = markerLocation.distance(from: originLocation!)
                    
                }
            }
            
            if let company = dicPlace["company"] as? String {
                strCompany = company
            }
            
            
            
        }
        
        
        uinfo.rLatitude = marker.position.latitude
        uinfo.rLongtitude = marker.position.longitude
        uinfo.rCompany = strCompany
        
        self.present(detailNavi!, animated: true, completion: nil)
         //*/
        
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//        mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        
        
        self.destCoordinate = nil
        
        searchController?.searchBar.text = ""
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        if marker.userData == nil {
//            return UIImageView(image: UIImage(named: "Map_InfoWindow"))
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 62, height: 27))
            button.setBackgroundImage(UIImage(named: "Map_InfoWindow"), for: UIControlState.normal)
            button.setTitle(marker.title, for: UIControlState.normal)
            button.setTitleColor(UIColor.gray, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0)
            return button
        }
        
        return nil
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
//        mapView.settings.myLocationButton = true      // Default Button
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
        
        self.myCoordinate = location.coordinate
        
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

// Google Sample
// Handle the user's selection.
// MARK: - GMSAutocompleteResultsViewControllerDelegate
extension MainViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        print("Place Coordinate: \(place.coordinate)")
        
        self.destCoordinate = place.coordinate
        searchController?.searchBar.text = place.name
        self.mapViewPositon(coordinate: place.coordinate)   // 2018.05.21
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
// Google Sample


extension GMSMapView {
    func getCenterCoordinate() -> CLLocationCoordinate2D {
        let centerPoint = self.center
        let centerCoordinate = self.projection.coordinate(for: centerPoint)
        return centerCoordinate
    }
    
    func getTopCenterCoordinate() -> CLLocationCoordinate2D {
        // to get coordinate from CGPoint of your map
        let topCenterCoor = self.convert(CGPoint(x: self.frame.size.width, y: 0), from: self)
        let point = self.projection.coordinate(for: topCenterCoor)
        return point
    }
    
    func getRadius() -> CLLocationDistance {
        let centerCoordinate = getCenterCoordinate()
        let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        let topCenterCoordinate = self.getTopCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        let radius = CLLocationDistance(centerLocation.distance(from: topCenterLocation))
        return round(radius)
    }
}
