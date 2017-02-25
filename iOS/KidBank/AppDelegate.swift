//
//  AppDelegate.swift
//  KidBank
//
//  Created by A Arrow on 2/3/17.
//  Copyright © 2017 higher.team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var listAtms: NSArray = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/atms")!
        //let URL: NSURL = NSURL(string: "http://127.0.0.1:3000/api/v1/atms")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "GET"

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in

            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                self.listAtms = parsedData["result"] as! NSArray
                
                 // let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //NSLog("\(self.window)")
                
                let first = self.window?.rootViewController?.childViewControllers[0] as! SecondViewController
                first.updateAtms(list: self.listAtms)
                let second = self.window?.rootViewController?.childViewControllers[1] as! SecondViewController
                second.updateAtms(list: self.listAtms)
                

                
            } catch let error as NSError {
                print(error)
            }
            
            
            
        });
        
        task.resume()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

