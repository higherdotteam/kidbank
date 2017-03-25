import UIKit

class AccountController: UIViewController{
    @IBOutlet var logout: UIButton!
    @IBOutlet var display: UILabel!
    
    @IBAction func doLogout(sender: UIButton) {
       UserDefaults.standard.removeObject(forKey: "kb_username")
       UserDefaults.standard.removeObject(forKey: "kb_token")
       display.text = "You are not logged in."
        logout.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let username = UserDefaults.standard.value(forKey: "kb_username")
        if username != nil {
          display.text = "You are logged in as: \(username!)"
          logout.isHidden = false
        }
    }
}
