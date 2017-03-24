import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    
    @IBAction func cancelModal(sender: UIButton) {
        self.view.endEditing(true)
        username.isHidden = true
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func signup(sender: UIButton) {
        signupButton.isHidden = true
        loginButton.isHidden = true
        
        username.isHidden = false
        username.becomeFirstResponder()
        
        /*
        Timer.scheduledTimer(timeInterval: 1.0, target: self.username, selector: #selector(becomeFirstResponder), userInfo: nil, repeats: false)
        */
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
