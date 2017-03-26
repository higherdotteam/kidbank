import UIKit

class AtmController: UIViewController{
    @IBOutlet var deposit: UIButton!
    @IBOutlet var display: UILabel!
    
    @IBAction func doDeposit(sender: UIButton) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        display.text = "hello"
    }
}
