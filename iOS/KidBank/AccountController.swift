import UIKit

class AccountController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var logout: UIButton!
    @IBOutlet var display: UILabel!
    @IBOutlet var table: UITableView!
    
    @IBAction func doLogout(sender: UIButton) {
       UserDefaults.standard.removeObject(forKey: "kb_username")
       UserDefaults.standard.removeObject(forKey: "kb_token")
       display.text = "Go find some ATMs!"
        logout.isHidden = true
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
        
        cell.textLabel?.text = "hi there"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
