import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var usernameForLogin: UITextField!
    @IBOutlet var phoneForLogin: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var bigLoginButton: UIButton!
    
    var state: Int = 0
    
    func taken() {
        let alert = UIAlertController(title: "Alert", message: "That username is already taken", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func badLogin() {
        let alert = UIAlertController(title: "Alert", message: "Login not correct", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func doBigLogin(sender: UIButton) {
        let u = usernameForLogin.text!.trimmingCharacters(in: .whitespaces)
        let p = phoneForLogin.text!.trimmingCharacters(in: .whitespaces)
        var yeserr = false as Bool
        
        if u.characters.count < 2 {
            yeserr = true
        }
        
        if p.characters.count < 10 {
            yeserr = true
        }

        if yeserr {
            let alert = UIAlertController(title: "Alert", message: "Login not correct", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            usernameForLogin.isEnabled = false
            phoneForLogin.isEnabled = false
            usernameForLogin.resignFirstResponder()
            phoneForLogin.resignFirstResponder()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            doLoginPost()
        }
    }
    
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
        phoneForLogin.isHidden = false
        bigLoginButton.isHidden = false
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
              username.isEnabled = false
              phone.isEnabled = false
              username.resignFirstResponder()
              phone.resignFirstResponder()
              UIApplication.shared.isNetworkActivityIndicatorVisible = true
              doCreatePost()
                
            }
        }
        /*
        Timer.scheduledTimer(timeInterval: 1.0, target: self.username, selector: #selector(becomeFirstResponder), userInfo: nil, repeats: false)
        */
    }
    
    func getListOfVisitedAtms() {
    
    }
    
    func doLoginPost() {
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/customers/login")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "POST"
        let bodyData = "username=\(usernameForLogin.text!)&password=\(phoneForLogin.text!)"
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            let httpResponse = response as! HTTPURLResponse
            
            
            if httpResponse.statusCode == 200 {
                
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let customer = parsedData["result"] as! NSDictionary
                    
                    UserDefaults.standard.setValue(customer.value(forKey: "username"), forKey: "kb_username")
                    UserDefaults.standard.setValue(customer.value(forKey: "token"), forKey: "kb_token")
                    
                    self.getListOfVisitedAtms()
                    
                } catch let error as NSError {
                    print(error)
                }
                
                self.dismiss(animated: false, completion: nil)
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.usernameForLogin.isEnabled = true
                    self.phoneForLogin.isEnabled = true
                    self.badLogin()
                }
            }
            
        });
        
        task.resume()
    }

    
    func doCreatePost() {
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/customers")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "POST"
        let bodyData = "username=\(username.text!)&phone=\(phone.text!)"
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            let httpResponse = response as! HTTPURLResponse
            
            
            if httpResponse.statusCode == 200 {
            
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let customer = parsedData["result"] as! NSDictionary
                    
                    UserDefaults.standard.setValue(customer.value(forKey: "username"), forKey: "kb_username")
                    UserDefaults.standard.setValue(customer.value(forKey: "token"), forKey: "kb_token")

                } catch let error as NSError {
                    print(error)
                }
                
                self.dismiss(animated: false, completion: nil)
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  self.username.isEnabled = true
                  self.phone.isEnabled = true
                  self.taken()
                }
            }
            
        });
        
        task.resume()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            phone.becomeFirstResponder()
        } else if textField.tag == 2 {
            phoneForLogin.becomeFirstResponder()
        } else if textField.tag == 3 {
            self.doBigLogin(sender: UIButton())
        }
        
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.username.tag = 1
        self.usernameForLogin.delegate = self
        self.usernameForLogin.tag = 2
        
        self.phoneForLogin.delegate = self
        self.phoneForLogin.tag = 3

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
