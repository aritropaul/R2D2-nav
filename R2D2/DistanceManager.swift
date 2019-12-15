//
//  DistanceManager.swift
//  R2D2
//
//  Created by Aritro Paul on 15/12/19.
//  Copyright © 2019 Aritro Paul. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

protocol PedometerDelegate : class {
    func distanceTraveled(distance: Double)
    func timeNeeded(time: Double)
}

class Pedometer : NSObject {
    
    let pedometer = CMPedometer()
    var distanceToCover: Double?
    weak var delegate: PedometerDelegate?
    
    required init?(coder: NSCoder) {
        super.init()
        pedometer.startUpdates(from: Date()) { (data, err) in
            if let data = data {
                let totalTimeNeeded = Double(truncating: data.averageActivePace ?? 0)*Double(truncating: data.distance ?? 0)
                self.delegate?.timeNeeded(time: totalTimeNeeded)
                self.delegate?.distanceTraveled(distance: Double(truncating: data.distance ?? 0))
            }
        }
    }
    
    func startMeasuring() {
        pedometer.startUpdates(from: Date()) { (data, err) in
            if let data = data {
                let totalTimeNeeded = Double(truncating: data.averageActivePace ?? 0)*Double(truncating: data.distance ?? 0)
                self.delegate?.timeNeeded(time: totalTimeNeeded)
                self.delegate?.distanceTraveled(distance: Double(truncating: data.distance ?? 0))
            }
        }
    }
    
    func stopMeasuring() {
        pedometer.stopUpdates()
    }
    
}
