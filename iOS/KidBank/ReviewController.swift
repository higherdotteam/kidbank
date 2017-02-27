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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.list.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Submit") { (action, indexPath) in
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
