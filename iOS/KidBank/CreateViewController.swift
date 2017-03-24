import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    
    @IBAction func cancelModal(sender: UIButton) {
        //self.view.endEditing(true)
        username.resignFirstResponder()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.isEnabled = false
        username.resignFirstResponder()
        //textField.resignFirstResponder()
        return true
    }

    @IBAction func login(sender: UIButton) {
        signupButton.isHidden = true
        loginButton.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
