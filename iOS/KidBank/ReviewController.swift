//
//  ReviewController.swift
//  KidBank
//
//  Created by Andrew Arrow on 2/27/17.
//  Copyright © 2017 higher.team. All rights reserved.
//

import UIKit

extension Data {

    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

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
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func createBody(with parameters: [String: String]?, boundary: String, lat: String, lon: String) throws -> Data {
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        let latlon:String = "\(lat)_\(lon)"
        let name = "kidbank.jpg"
        
        let filename = self.getDocumentsDirectory().appendingPathComponent("kb_\(latlon).jpg").path
        
    
        if FileManager.default.fileExists(atPath: filename) == false {
            NSLog("zzz")
            return body
        }

        let image = UIImage(contentsOfFile: filename)
        let data = UIImageJPEGRepresentation(image!, 90) as Data?
        
        let mimetype = "image/jpg"
        let filePathKey = "image"
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(name)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(data!)
        body.append("\r\n")
    
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    func doPost(lat: String, lon: String) {
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/atms")!        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var parameters = Dictionary<String,String>()
        parameters["lat"] = lat
        parameters["lon"] = lon
        parameters["ifv"] = UIDevice.current.identifierForVendor?.uuidString
        
        request.httpBody = try? createBody(with: parameters, boundary: boundary, lat: lat, lon: lon)
        
        
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
            let lat = self.list[indexPath.row]["lat"] as! String
            let lon = self.list[indexPath.row]["lon"] as! String

            self.doPost(lat: lat, lon: lon)
            self.list.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        share.backgroundColor = UIColor.blue
        
        return [delete, share]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let lat = self.list[indexPath.row]["lat"] as! String
        let lon = self.list[indexPath.row]["lon"] as! String
        
        cell.textLabel?.text = "\(lat),\(lon)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
