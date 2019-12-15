//
//  DirectionalData.swift
//  R2D2
//
//  Created by Aritro Paul on 15/12/19.
//  Copyright © 2019 Aritro Paul. All rights reserved.
//

import Foundation


struct Directions : Codable {
    var currentLocation: String?
    var nextHeading: Double?
    var steps: [Steps]?
}

struct Steps : Codable{
    var distance: Double?
    var relativeHeading: Double?
}
