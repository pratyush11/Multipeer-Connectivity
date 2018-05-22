//
//  ViewController.swift
//  partyTest
//
//  Created by Pratyush on 5/22/18.
//  Copyright © 2018 Pratyush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var deviceList: UITextView!
    @IBOutlet weak var connectionLabel: UILabel!
    
    var deviceListString: String!
    var newDeviceListString: String!
    
    //Bonjour Service implementation
    let bonjourService = BonjourService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bonjourService.delegate = self
    }
    
}

extension ViewController : BonjourServiceManagerDelegate {
    
    func foundDevicesChanged(manager: BonjourService, peerDevices: [String]) {
        
        for device in peerDevices{
            deviceListString.append(device)
        }
        deviceList.text = deviceListString
        
    }
    
    func messageChanged(manager: BonjourService, messageString: String) {
        messageField.text = messageString
    }
    
    func connectedDevicesChanged(manager: BonjourService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.newDeviceListString = "Connected to:"
            
            for device in connectedDevices {
                self.newDeviceListString.append(" \(device)")
            }
            
            self.connectionLabel.text = self.newDeviceListString
        }
    }
}

