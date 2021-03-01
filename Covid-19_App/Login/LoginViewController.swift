import UIKit


struct UserManager {
    static var username = ""
}

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var verticalConstrain: NSLayoutConstraint!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private let loginFieldValidator = LoginFieldsValidator()
    
    private let usernameKey = "lastSuccessLogin"
    
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

     verticalConstrain.constant = 350
        

      UIView.animate(withDuration: 1) { [weak self] in
        self?.view.layoutIfNeeded()
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loginButton.isHidden = true
        
        userNameTextField.addTarget(self, action: #selector(buttonDidAppear), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(buttonDidAppear), for: .editingChanged)
        
        
        let user = User (username: "Vasya)", email: "apple@apple.com")
        let encoder = PropertyListEncoder()
        let data = try? encoder.encode(user)
        UserDefaults.standard.setValue(data, forKey: usernameKey)
        
        let lastSuccessLoginData = UserDefaults.standard.data(forKey: usernameKey)
        
        if let lastSuccessLoginData = lastSuccessLoginData {
            
        let decoder = PropertyListDecoder()
            
            _ = try? decoder.decode(User.self, from: lastSuccessLoginData)
        
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      verticalConstrain.constant = view.bounds.height
    }
    

    @IBAction private func loginButtonSelected(_ sender: UIButton) {
        UserManager.username = userNameTextField.text!
        let viewController = TabBar ()
        viewController.textLabel = userNameTextField.text ?? ""
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func buttonDidAppear ( _ sender : UITextField ){
        if loginFieldValidator.validator(usernameTextField: userNameTextField.text!, passwordTextField: passwordTextField.text!) {
            
            loginButton.isHidden = true
        }else{
            loginButton.isHidden = false
        }
    }
    
    
    
}



