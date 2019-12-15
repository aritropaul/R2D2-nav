//
//  HomeViewController.swift
//  R2D2
//
//  Created by Aritro Paul on 15/12/19.
//  Copyright © 2019 Aritro Paul. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var finalDestinationButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var scannerView: QRScannerView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var currentLocation: String?
    var finalDestination: String?
    
    var locations = ["Gallery 1", "VITTBI Office", "CTS Office"]
    
    override func viewDidLayoutSubviews() {
        currentLocationButton.layer.cornerRadius = 8
        finalDestinationButton.layer.cornerRadius = 8
        scannerView.layer.cornerRadius = scannerView.frame.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scannerView.delegate = self
    }
    
    @IBAction func finalTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Destination", message: "\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.isModalInPresentation = true
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: alert.view.frame.width - 25, height: 140))
        pickerFrame.tag = 555
        pickerFrame.delegate = self
        pickerFrame.dataSource = self
        
        alert.view.addSubview(pickerFrame)
        alert.view.bringSubviewToFront(pickerFrame)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.finalDestination = self.locations[pickerFrame.selectedRow(inComponent: 0)]
            print(self.finalDestination)
            
        })
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func currentTapped(_ sender: Any) {
        scannerView.isRunning ? scannerView.stop() : scannerView.start()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? NavigationViewController {
            controller.destinationLocation = self.finalDestination
        }
    }
    
}

extension HomeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
}

extension HomeViewController : QRScannerViewDelegate {
    func QRScannerDidFail() {
        print("failed")
    }
    
    func QRScannerSucceededWithString(_ string: String) {
        print(string)
        locationLabel.text = "You are at \(string)!"
        self.performSegue(withIdentifier: "Navigate", sender: Any?.self)
    }
    
    func QRScanningDidStop() {
        print("stopped")
    }
    
    
}
