//
//  CompassManager.swift
//  R2D2
//
//  Created by Aritro Paul on 15/12/19.
//  Copyright © 2019 Aritro Paul. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol CompassManagerDelegate: class {
    func getHeading(angle: Double)
}

class CompassManager: UIView {
    
    let locationManager = CLLocationManager()
    weak var delegate: CompassManagerDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
    }
    
}

extension CompassManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
      let angle = newHeading.trueHeading.toRadians
      delegate?.getHeading(angle: angle)
    }
}


extension Double {
  var toRadians: Double { return self * .pi / 180 }
  var toDegrees: Double { return self * 180 / .pi }
}
