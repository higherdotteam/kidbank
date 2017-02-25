//
//  FirstViewController.swift
//  KidBank
//
//  Created by A Arrow on 2/3/17.
//  Copyright © 2017 higher.team. All rights reserved.
//

import UIKit
import MapKit

extension FirstViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //1
        if locations.count > 0 {
            let location = locations.last!
            print("Accuracy: \(location.horizontalAccuracy)")
            
            //2
            if location.horizontalAccuracy < 100 {
                //3
                manager.stopUpdatingLocation()
                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                var map: MKMapView?
                map = super.view as! MKMapView?
                map?.region = region
            }
        }
    }
}	

class FirstViewController: UIViewController {
    
    fileprivate let locationManager = CLLocationManager()
    
    func updateAtms(list: NSArray) {
        var map: MKMapView?
        map = super.view as! MKMapView?
        
        for (thing) in list {
            
            if let foo = thing as? Dictionary<String, Double> {
                let lat = foo["lat"]! as Double
                let lon = foo["lon"]! as Double
                NSLog("\(lat) \(lon)")
                
                let location = CLLocationCoordinate2DMake(lat, lon)
                let annotation = PlaceAnnotation(location: location, title: "ATM")
                map!.addAnnotation(annotation)
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        // https://www.raywenderlich.com/146436/augmented-reality-ios-tutorial-location-based-2
         var map: MKMapView?
        map = super.view as! MKMapView?
        NSLog("\(map)")
        map!.mapType = MKMapType.standard

        
        /*let latitude:CLLocationDegrees = 33.988914
        
        let longitude:CLLocationDegrees = -118.400969
        
        
        let latDelta:CLLocationDegrees = 0.025
        
        let lonDelta:CLLocationDegrees = 0.025
        
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region = MKCoordinateRegionMake(location, span)
        
        
        let annotation = PlaceAnnotation(location: location, title: "Test")
        map!.addAnnotation(annotation)

        let l2:CLLocationDegrees = 33.987914
        let l3:CLLocationDegrees = -118.400869
        let location2 = CLLocationCoordinate2DMake(l2, l3)
        let annotation2 = PlaceAnnotation(location: location2, title: "Test2")
        map!.addAnnotation(annotation2)
        
        map!.setRegion(region, animated: false)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

