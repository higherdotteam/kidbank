import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    
    @IBAction func cancelModal(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signup(sender: UIButton) {
        signupButton.isHidden = true
        loginButton.isHidden = true
        
        username.isHidden = false
    }

    @IBAction func login(sender: UIButton) {
        signupButton.isHidden = true
        loginButton.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
