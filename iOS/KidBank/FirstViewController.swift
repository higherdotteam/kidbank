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
        // Do any additional setup after loading the view, typically from a nib.
        
        // https://www.raywenderlich.com/146436/augmented-reality-ios-tutorial-location-based-2
         var map: MKMapView?
        map = super.view as! MKMapView?
        NSLog("\(map)")
        let latitude:CLLocationDegrees = 33.988914
        
        let longitude:CLLocationDegrees = -118.400969
        
        
        let latDelta:CLLocationDegrees = 0.025
        
        let lonDelta:CLLocationDegrees = 0.025
        
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region = MKCoordinateRegionMake(location, span)
        
        
        map!.mapType = MKMapType.standard
        map!.setRegion(region, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

