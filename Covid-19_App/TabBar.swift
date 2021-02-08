import UIKit

class TabBar: UITabBarController {
    
    var textLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        
        let newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        
        newsViewController.title = "News"
      
        
        let casesViewController = storyboard.instantiateViewController(withIdentifier: "CasesViewController") as! CasesViewController
        
        casesViewController.title = "Cases"
       
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "LogOutController") as! LogOutController
        
        profileViewController.textLabel = textLabel
        profileViewController.title = "Profile"

        
        let navigationViewController = UINavigationController(rootViewController: newsViewController)
        let navigationViewController2 = UINavigationController(rootViewController: casesViewController)
        let navigationViewController3 = UINavigationController(rootViewController: profileViewController)
        
        let viewControllers = [navigationViewController, navigationViewController2, navigationViewController3]
        
        setViewControllers(viewControllers, animated: false)
        
        modalPresentationStyle = .fullScreen
 }
    
    
}

