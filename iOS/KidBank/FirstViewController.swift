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
        
        

        let annotation = PlaceAnnotation(location: location, title: "Test")
        map!.addAnnotation(annotation)

        let l2:CLLocationDegrees = 33.987914
        let l3:CLLocationDegrees = -118.400869
        let location2 = CLLocationCoordinate2DMake(l2, l3)
        let annotation2 = PlaceAnnotation(location: location2, title: "Test2")
        map!.addAnnotation(annotation2)
        
        map!.setRegion(region, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

