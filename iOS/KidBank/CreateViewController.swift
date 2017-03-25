import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var usernameForLogin: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    
    @IBAction func cancelModal(sender: UIButton) {
        //self.view.endEditing(true)
        username.resignFirstResponder()
        username.isHidden = true
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func login(sender: UIButton) {
        signupButton.isHidden = true
        loginButton.isHidden = true
        
        usernameForLogin.isHidden = false
        usernameForLogin.becomeFirstResponder()
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
        if textField.tag == 1 {
            username.isEnabled = false
            username.resignFirstResponder()
            //textField.resignFirstResponder()
            
            let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/customers")!
            let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
            request.httpMethod = "POST"
            let bodyData = "username=\(username.text!)"
            
            request.httpBody = bodyData.data(using: String.Encoding.utf8);
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                
                let httpResponse = response as! HTTPURLResponse
                
                
                if httpResponse.statusCode == 200 {
                    
                    let username = String(data: data!, encoding: .utf8)
                    
                    UserDefaults.standard.setValue(username, forKey: "kb_username")
                    
                    self.username.isHidden = true
                    self.dismiss(animated: false, completion: nil)
                    
                } else {
                    
                }
                
            });
            
            task.resume()
        } else if textField.tag == 2 {
            UserDefaults.standard.setValue(usernameForLogin.text!, forKey: "kb_username")
            
            self.username.isHidden = true
            self.dismiss(animated: false, completion: nil)
        }
        
        return true
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.username.tag = 1
        self.usernameForLogin.delegate = self
        self.usernameForLogin.tag = 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
