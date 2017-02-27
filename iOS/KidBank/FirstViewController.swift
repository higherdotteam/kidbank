//
//  FirstViewController.swift
//  KidBank
//
//  Created by A Arrow on 2/3/17.
//  Copyright © 2017 higher.team. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://www.raywenderlich.com/146436/augmented-reality-ios-tutorial-location-based-2
        var map: MKMapView?
        map = super.view as! MKMapView?
        NSLog("\(map)")
        map!.mapType = MKMapType.standard
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let svc = appDelegate.window?.rootViewController?.childViewControllers[0] as! SecondViewController
        
        for (thing) in svc.listOfAtms {
            let lat = thing["lat"]
            let lon = thing["lon"]
            
            NSLog("aaaa1111 \(lat)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

