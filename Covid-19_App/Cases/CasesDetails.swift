import UIKit

class CasesDetails: UIViewController {
    
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    var country: Cases?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        confirmedLabel.text = "\(NSLocalizedString("CONFIRMED", comment: "")) \(country!.infected)"

        

        deathLabel.text = "\(NSLocalizedString("DEATH", comment: "")) \(country!.recovered ?? 0)"
        
    }
    
}

