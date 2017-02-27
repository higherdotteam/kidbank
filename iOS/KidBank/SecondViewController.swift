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

class SecondViewController: ARViewController, ARDataSource {
    
    @IBOutlet var addNewButton: UIButton!
    
    func addAtmLocation(_ sender: UITapGestureRecognizer) {
        //NSLog("addAtmLocation \(sender)")
        //locationManager.startUpdatingLocation()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tbc = appDelegate.window?.rootViewController as! UITabBarController
        
        let rc = appDelegate.window?.rootViewController?.childViewControllers[2] as! ReviewController
        
        let dict : NSDictionary = [ "lat" : self.trackingManager.userLocation?.coordinate.latitude, "lon" : self.trackingManager.userLocation?.coordinate.longitude]
        rc.list.append(dict)
        tbc.selectedIndex = 2
        rc.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.addAtmLocation(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView
    {
        let annotationView = TestAnnotationView()
        annotationView.frame = CGRect(x: 100,y: 100,width: 150,height: 50)
        return annotationView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

