import UIKit

class AccountController: UIViewController{
    @IBOutlet var logout: UIButton!
    @IBOutlet var display: UILabel!
    
    @IBAction func doLogout(sender: UIButton) {
       UserDefaults.standard.removeObject(forKey: "kb_username")
    }
}
