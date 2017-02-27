//
//  ReviewController.swift
//  KidBank
//
//  Created by Andrew Arrow on 2/27/17.
//  Copyright © 2017 higher.team. All rights reserved.
//

import UIKit

class ReviewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var list: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func doPost(lat: Double, lon: Double) {
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/atms")!        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "POST"
        let bodyData = "lat=\(lat)&lon=\(lon)&ifv=\(UIDevice.current.identifierForVendor?.uuidString)"
        NSLog("\(bodyData)")
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
        });
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.list.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Submit") { (action, indexPath) in
            let lat = self.list[indexPath.row]["lat"] as! Double
            let lon = self.list[indexPath.row]["lon"] as! Double

            self.doPost(lat: lat, lon: lon)
            self.list.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        share.backgroundColor = UIColor.blue
        
        return [delete, share]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let lat = self.list[indexPath.row]["lat"] as! Double
        let lon = self.list[indexPath.row]["lon"] as! Double
        cell.textLabel?.text = "\(lat),\(lon)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
