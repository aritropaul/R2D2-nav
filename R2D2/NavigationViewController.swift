//
//  NavigationViewController.swift
//  R2D2
//
//  Created by Aritro Paul on 15/12/19.
//  Copyright © 2019 Aritro Paul. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var distanceInMeters: UILabel!
    @IBOutlet weak var timeInMinutes: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var directionalArrowImage: UIImageView!
    
    var destinationLocation: String?
    var directions: Map?
    
    override func viewDidLayoutSubviews() {
        infoView.alpha = 0.85
        infoView.layer.cornerRadius = 12
        backButton.layer.cornerRadius = 8
        directionalArrowImage.layer.cornerRadius = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.delegate = self
        locationLabel.text = destinationLocation
        
        
        if let path = Bundle.main.path(forResource: "Map", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//                print(String(data: data, encoding: .utf8))
                directions = try JSONDecoder().decode(Map.self, from: data)
                print("jsonData:\(directions)")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func mapParser() {
        
    }

}

extension NavigationViewController : NavigationViewDelegate {
    func reachedDestination() {
        //
    }
    
    func navigationDidStop() {
        //
    }
    
    
}
