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

    @IBOutlet var stepsTitleLabel: UILabel!
    @IBOutlet var distanceTitleLabel: UILabel!

    @IBOutlet var stepsLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let types = Set([
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        ])

        healthStore.requestAuthorization(toShare: types, read: types, completion: {success, error in
            if success {
                print("Success")
            }
            else {
                print("Error")
            }
        })
        stepsTitleLabel.layer.masksToBounds = true
        stepsTitleLabel.layer.cornerRadius = 30.0
        distanceTitleLabel.layer.masksToBounds = true
        distanceTitleLabel.layer.cornerRadius = 30.0

//        getSteps()
        getHeight()
    }

    func getSteps() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let startDate: Date = dateFormatter.date(from: "2018/05/07")!
        let endDate: Date = dateFormatter.date(from: "2018/05/11")!

        let type: HKQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let predicate: NSPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        let sort: [NSSortDescriptor] = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]

        let query: HKSampleQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: 10, sortDescriptors: sort, resultsHandler: { (query, result, error) in
            print(result?.first ?? 0)
        })

        print(healthStore.execute(query))
    }
    
    func getHeight() {
        let type: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let sort: [NSSortDescriptor] = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]
        let query: HKSampleQuery = HKSampleQuery(sampleType: type, predicate: nil, limit: 1, sortDescriptors: sort, resultsHandler: { (query, result , error) in
            if let e = error {
                print("Error: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                guard let r = result else {
                    return
                }
                print(r)
            }
        })
        
        print(healthStore.execute(query))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

