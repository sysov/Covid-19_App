import UIKit

class TabBar: UITabBarController {
    
    var textLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        
        let newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        
        newsViewController.title = NSLocalizedString("NEWSVIEWCONTROLLER", comment: "")
      
        
        let casesViewController = storyboard.instantiateViewController(withIdentifier: "CasesViewController") as! CasesViewController
        
        casesViewController.title = NSLocalizedString("CASESEVIEWCONTROLLER", comment: "")
       
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "LogOutController") as! LogOutController
        
        profileViewController.textLabel = textLabel
        profileViewController.title = NSLocalizedString("PROFILEVIEWCONTROLLER", comment: "")

        
        let navigationViewController = UINavigationController(rootViewController: newsViewController)
        let navigationViewController2 = UINavigationController(rootViewController: casesViewController)
        let navigationViewController3 = UINavigationController(rootViewController: profileViewController)
        
        let viewControllers = [navigationViewController, navigationViewController2, navigationViewController3]
        
        setViewControllers(viewControllers, animated: false)
        
        modalPresentationStyle = .fullScreen
 }
    
    
}

