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
        var map: MKMapView?
        map = super.view as! MKMapView?
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let svc = appDelegate.window?.rootViewController?.childViewControllers[0] as! SecondViewController
     
        var first : Bool
        first = true
        for (thing) in svc.listOfAtms {
            let lat = thing["lat"] as! Double
            let lon = thing["lon"] as! Double
            
            let location = CLLocationCoordinate2DMake(lat, lon)
            let annotation = PlaceAnnotation(location: location, title: "ATM")
            map!.addAnnotation(annotation)
            
            if first {
              let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
              let region = MKCoordinateRegion(center: location, span: span)
              map!.region = region
              first = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

