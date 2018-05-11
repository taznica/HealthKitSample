//
//  ViewController.swift
//  HealthKitSample
//
//  Created by Taichi Tsuchida on 2018/05/11.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    let healthStore: HKHealthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let types = Set([
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        ])

        healthStore.requestAuthorization(toShare: types, read: types, completion: {success, error in
            if success {
                print("Success")
            }
            else {
                print("Error")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

