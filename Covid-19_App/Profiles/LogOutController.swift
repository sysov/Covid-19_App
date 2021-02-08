import UIKit

class LogOutController : UIViewController {

    @IBOutlet weak var usernameValue: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var textLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        usernameValue.text = UserManager.username
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        ListEventManager.singleton.notify()
    }
    
}
