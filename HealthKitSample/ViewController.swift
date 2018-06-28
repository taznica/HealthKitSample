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

        stepsTitleLabel.layer.masksToBounds = true
        stepsTitleLabel.layer.cornerRadius = 30.0
        distanceTitleLabel.layer.masksToBounds = true
        distanceTitleLabel.layer.cornerRadius = 30.0

        healthStore.askAuthorization()

        healthStore.getStepsOfToday(completion: {steps in
            DispatchQueue.main.async {
                self.stepsLabel.text = steps.description
            }
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

