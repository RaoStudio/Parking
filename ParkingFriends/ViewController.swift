//
//  ViewController.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 3. 5..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Commit Test ~ 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    static var memoryUsage: String { var taskInfo = task_vm_info_data_t() var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4 let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) { $0.withMemoryRebound(to: integer_t.self, capacity: 1) { task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count) } } var used: UInt64 = 0 if result == KERN_SUCCESS { used = UInt64(taskInfo.phys_footprint) } let total = ProcessInfo.processInfo.physicalMemory let bytesInMegabyte = 1024.0 * 1024.0 let usedMemory: Double = Double(used) / bytesInMegabyte let totalMemory: Double = Double(total) / bytesInMegabyte return String(format: "%.1f MB / %.0f MB", usedMemory, totalMemory) }
}

