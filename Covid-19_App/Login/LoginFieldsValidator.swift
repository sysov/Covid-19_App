import Foundation
import UIKit

class LoginFieldsValidator{
    func validator(usernameTextField: String, passwordTextField: String) -> Bool {
        if passwordTextField != "" && usernameTextField != "" {
            return false
        } else {
            return true
        }
    }
}
