import UIKit

class CasesDetails: UIViewController {
    
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    var country: Cases?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmedLabel.text = " Confirmed: \(country!.infected)"
        deathLabel.text = "Death: \(country!.recovered ?? 0)"
        
    }
    
}

