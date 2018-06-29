//
// Created by Taichi Tsuchida on 2018/06/14.
// Copyright (c) 2018 Taichi Tsuchida. All rights reserved.
//

import Foundation
import HealthKit


extension HKHealthStore {

    func askAuthorization() {
        let types = Set([
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        ])

        self.requestAuthorization(toShare: types, read: types, completion: {success, error in
            if success {
                print("Success")
            }
            else {
                print("Error")
            }
        })
    }


    func getSteps(startDate: Date, endDate: Date, completion: ((_ steps: Int) -> Void)!) {
        let type: HKQuantityType? = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        let predicate: NSPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])

        let query: HKSampleQuery = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil, resultsHandler: { query, results, error in
            var steps = 0
            
            guard let samples = results else {
                print(error.debugDescription)
                return
            }
            
            if samples.count > 0 {
                for sample in samples as! [HKQuantitySample] {
                    steps += Int(sample.quantity.doubleValue(for: HKUnit.count()))
                }
            }
            
            completion(steps)
        })

        self.execute(query)
    }


    func getStepsOfToday(completion: ((_ steps: Int) -> Void)!) {
        let calender = Calendar(identifier: .japanese)
        let startDate: Date = calender.startOfDay(for: Date())
        let endDate: Date = Date(timeIntervalSinceNow: startDate.timeIntervalSinceNow + 86400)

        print(startDate)
        print(endDate)

        getSteps(startDate: startDate, endDate: endDate, completion: completion)
    }


    func getStepsOfTheDay(date: Date, completion: ((_ steps: Int) -> Void)!) {
        let calendar = Calendar(identifier: .japanese)
        let startDate: Date = calendar.startOfDay(for: date)
        let endDate: Date = Date(timeIntervalSinceNow: startDate.timeIntervalSinceNow + 86400)

        getSteps(startDate: startDate, endDate: endDate, completion: completion)
    }
}
