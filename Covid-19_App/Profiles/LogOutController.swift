import UIKit
import Contacts
import MapKit

class LogOutController : UIViewController, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    

    @IBOutlet weak var usernameValue: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var textLabel = ""
    var contacts = [FetchedContacts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        usernameValue.text = UserManager.username
        
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.fetchContacts()
        
        
        mapView.userTrackingMode = .follow
        let annotations = LocationsStorage.shared.locations.map { annotationForLocation($0) }
        mapView.addAnnotations(annotations)
        NotificationCenter.default.addObserver(self, selector: #selector(newLocationAdded(_:)), name: .newLocationSaved, object: nil)

        
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        ListEventManager.singleton.notify()
    }
  
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].firstName + " " + contacts[indexPath.row].lastName
        cell.detailTextLabel?.text = contacts[indexPath.row].email

        return cell
    }
    
    private func fetchContacts() {
    
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        self.contacts.append(FetchedContacts(firstName: contact.givenName, lastName: contact.familyName, email: contact.phoneNumbers.first?.value.stringValue ?? ""))
                        print(contact)
                    })
                    self.tableView.reloadData()
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    
    func annotationForLocation(_ location: Location) -> MKAnnotation {
      let annotation = MKPointAnnotation()
      annotation.title = location.dateString
      annotation.coordinate = location.coordinates
      return annotation
    }
    
    @objc func newLocationAdded(_ notification: Notification) {
      guard let location = notification.userInfo?["location"] as? Location else {
        return
      }
      
      let annotation = annotationForLocation(location)
      mapView.addAnnotation(annotation)
    }
    
}
