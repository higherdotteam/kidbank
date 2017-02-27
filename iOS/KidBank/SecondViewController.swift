//
//  SecondViewController.swift
//  KidBank
//
//  Created by A Arrow on 2/3/17.
//  Copyright © 2017 higher.team. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


extension SecondViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("gotLocation")
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
                
                NSLog("\(region)")
                
                let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/atms")!
                //let URL: NSURL = NSURL(string: "http://127.0.0.1:3000/api/v1/atms")!
                let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
                request.httpMethod = "POST"
                let bodyData = "lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&h=\(currentHeading)"
                NSLog("\(bodyData)")
                
                request.httpBody = bodyData.data(using: String.Encoding.utf8);
                
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                
                let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                    
                });
                
                task.resume()
            }
        }
    }
}

class SecondViewController: ARViewController, ARDataSource {
    
    fileprivate let locationManager = CLLocationManager()
    
    @IBOutlet var addNewButton: UIButton!
    
    func updateAtms(list: NSArray) {
        
        var annotations: [ARAnnotation] = []
        
        for (thing) in list {
            
            if let foo = thing as? Dictionary<String, Double> {
                let lat = foo["lat"]! as Double
                let lon = foo["lon"]! as Double
                NSLog("\(lat) \(lon)")
                
    
                let annotation = ARAnnotation()
                annotation.location = CLLocation(latitude: lat, longitude: lon)
                annotation.title = "ATM"
                annotations.append(annotation)
            }
        }
        
        //self.setAnnotations(annotations)
        
    }
    
    
    func addAtmLocation(_ sender: UITapGestureRecognizer) {
        //NSLog("addAtmLocation \(sender)")
        //locationManager.startUpdatingLocation()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tbc = appDelegate.window?.rootViewController as! UITabBarController
        
        let rc = appDelegate.window?.rootViewController?.childViewControllers[2] as! ReviewController
        
        
        let dict : NSDictionary = [ "lat" : 33.333341, "lon" : -118.121]
        rc.list.append(dict)
        tbc.selectedIndex = 2
        rc.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        self.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.addAtmLocation(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView
    {
        // Annotation views should be lightweight views, try to avoid xibs and autolayout all together.
        let annotationView = TestAnnotationView()
        annotationView.frame = CGRect(x: 100,y: 100,width: 150,height: 50)
        return annotationView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

