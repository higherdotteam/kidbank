import UIKit

class AtmController: UIViewController{
    var nearestAtm: NSDictionary = NSDictionary()
    
    @IBOutlet var deposit: UIButton!
    @IBOutlet var display: UILabel!
    
    @IBAction func doDeposit(sender: UIButton) {
        doDepositPost()
        self.dismiss(animated: false, completion: nil)
    }
    
    func doDepositPost() {
        let atmid = nearestAtm.value(forKey: "id") as! Int?
        let t = UserDefaults.standard.value(forKey: "kb_token")
        
        let URL: NSURL = NSURL(string: "https://kidbank.team/api/v1/atms/\(atmid!)/deposit")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL as URL)
        request.httpMethod = "POST"
        let bodyData = "token=\(t!)"
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            let httpResponse = response as! HTTPURLResponse
            
            
            if httpResponse.statusCode == 200 {
          
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let ac = appDelegate.window?.rootViewController?.childViewControllers[3] as! AccountController
                ac.loadAtmsForUser()
                
                
            } else {
                
            }
            
        });
        
        task.resume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        display.text = nearestAtm.value(forKey: "words") as! String?
    }
}
