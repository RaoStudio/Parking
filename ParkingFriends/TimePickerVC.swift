//
//  TimePickerVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 15..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class TimePickerVC: UIViewController {

    @IBOutlet var startPicker: UIDatePicker!
    @IBOutlet var endPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "주차시간 선택"
        
        /*
        if let nItem = self.navigationController?.navigationItem {
            nItem.title = "주차시간 선택"
        }
         */
        
        
        //*
        setUpTimePicker()
        
        startPicker.minimumDate = Date()
        startPicker.maximumDate = Date(timeInterval: 60*60*24*2, since: Date())
         //*/
        
//        self.startPicker.setLimit(forCalendarComponent: .day, minimumUnit: 0, maximumUnit: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpTimePicker() {
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        minDateComponent.day = 01
        minDateComponent.month = 06
        minDateComponent.year = 2018
        
        let minDate = calendar.date(from: minDateComponent)
        print(" min date : \(String(describing: minDate))")
        
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        maxDateComponent.day = 0
        maxDateComponent.month = 06 + 1
        maxDateComponent.year = 2018
        
        let maxDate = calendar.date(from: maxDateComponent)
        print("max date : \(String(describing: maxDate))")
        
        startPicker.minimumDate = minDate! as Date
        startPicker.maximumDate =  maxDate! as Date
    }

    // MARK: - Action
    @IBAction func onBtnExit(_ sender: Any) {
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

extension UIDatePicker {
    
    func setLimit(forCalendarComponent component:Calendar.Component, minimumUnit min: Int, maximumUnit max: Int) {
        
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        guard let timeZone = TimeZone(identifier: "UTC") else { return }
        calendar.timeZone = timeZone
        
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        
        components.setValue(-min, for: component)
        if let maxDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.maximumDate = maxDate
        }
        
        components.setValue(-max, for: component)
        if let minDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.minimumDate = minDate
        }
    }
    
}
