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
    
    func checkSession(_ sender: UITapGestureRecognizer) {
        //let popup : PopupVC = self.storyboard?.instantiateViewControllerWithIdentifier("PopupVC") as! PopupVC
        //let navigationController = UINavigationController(rootViewController: popup)
        //navigationController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        //self.presentViewController(navigationController, animated: true, completion: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.isLoggedIn() == "" {
        
          let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
          let vc = mainStoryboard.instantiateViewController(withIdentifier: "test123") as! CreateViewController
        
          vc.view.backgroundColor = UIColor.white
          appDelegate.window?.rootViewController?.present(vc, animated: true, completion: {vc.email.becomeFirstResponder()})
        }
        

    }
    
    func addAtmLocation(_ sender: UITapGestureRecognizer) {
        //NSLog("addAtmLocation \(sender)")
        //locationManager.startUpdatingLocation()
        let ul = self.trackingManager.userLocation
        
        if ul == nil {
            return
        }
        
        let lat = self.trackingManager.userLocation?.coordinate.latitude
        let lon = self.trackingManager.userLocation?.coordinate.longitude
        let lats:String = String(format:"%.\(15)f", lat!)
        let lons:String = String(format:"%.\(15)f", lon!)
    
        saveStillImage(lats: lats, lons: lons)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tbc = appDelegate.window?.rootViewController as! UITabBarController
        
        let rc = appDelegate.window?.rootViewController?.childViewControllers[2] as! ReviewController
        
        let dict : NSDictionary = [ "lat" : lats, "lon" : lons]
        rc.list.append(dict)
        tbc.selectedIndex = 2
        rc.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.checkSession(_:)))
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

