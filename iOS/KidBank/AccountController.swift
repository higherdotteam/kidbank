import UIKit

class AccountController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var logout: UIButton!
    @IBOutlet var display: UILabel!
    @IBOutlet var table: UITableView!
    
    var listOfVisitedAtms: [NSDictionary] = []
    
    var list: [String] = ["","walk around town","look for atms","if atm already in system", "deposit money at it.", "", "if you found a new one","add it to system please"]
    
    func loadAtmsForUser() {
        self.listOfVisitedAtms = []
        
        let username = UserDefaults.standard.value(forKey: "kb_username")
        
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/customers/\(username!)/atms")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                let list = parsedData["result"] as! NSArray
                
                for (thing) in list {
                    self.listOfVisitedAtms.append(thing as! NSDictionary)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.table.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
        });
        
        task.resume()
        
    }
    @IBAction func doLogout(sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "kb_username")
        UserDefaults.standard.removeObject(forKey: "kb_token")
        display.text = "Go find some ATMs!"
        logout.isHidden = true
        self.listOfVisitedAtms = []
        self.table.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let username = UserDefaults.standard.value(forKey: "kb_username")
        if username != nil {
            display.text = "\(username!)"
            logout.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.table.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if listOfVisitedAtms.count == 0 {
          cell.textLabel?.text = list[indexPath.row]
        } else {
          let thing = listOfVisitedAtms[indexPath.row] 
          let words = thing["words"] as! String
          var happened_at = thing["happened_at"] as! String
          cell.textLabel?.text = "\(words) \(happened_at)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listOfVisitedAtms.count == 0 {
          return list.count
        }
        return listOfVisitedAtms.count
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
