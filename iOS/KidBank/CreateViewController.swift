import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var usernameForLogin: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    var state: Int = 0

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
        
        if (state == 0) {
            //signupButton.isHidden = true
            self.state = 1
            loginButton.isHidden = true
            
            username.isHidden = false
            username.becomeFirstResponder()
            phone.isHidden = false
        } else if (state == 1) {
            let u = username.text!.trimmingCharacters(in: .whitespaces)
            let p = phone.text!.trimmingCharacters(in: .whitespaces)
            var yeserr = false as Bool
            
            if u.characters.count < 2 {
              yeserr = true
            }
            
            if p.characters.count < 10 {
              yeserr = true
            }
            
            if yeserr {
                let alert = UIAlertController(title: "Alert", message: "Please enter username & phone", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
              doPost()
            }
        }
        /*
        Timer.scheduledTimer(timeInterval: 1.0, target: self.username, selector: #selector(becomeFirstResponder), userInfo: nil, repeats: false)
        */
    }
    
    func doPost() {
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/customers")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "POST"
        let bodyData = "username=\(username.text!)&phone=\(phone.text!)"
        
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
                let alert = UIAlertController(title: "Alert", message: "That username is already taken", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        });
        
        task.resume()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            username.isEnabled = false
            username.resignFirstResponder()
            //textField.resignFirstResponder()
            
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
