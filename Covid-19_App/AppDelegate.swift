import UIKit
import Swinject
import CoreLocation
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    static let geoCoder = CLGeocoder()
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    
    }
  

  extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
      // create CLLocation from the coordinates of CLVisit
      let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
      
      // Get location description
      AppDelegate.geoCoder.reverseGeocodeLocation(clLocation) { placemarks, _ in
        if let place = placemarks?.first {
          let description = "\(place)"
          self.newVisitReceived(visit, description: description)
        }
      }
    }
    
    func newVisitReceived(_ visit: CLVisit, description: String) {
      let location = Location(visit: visit, descriptionString: description)
      LocationsStorage.shared.saveLocationOnDisk(location)
      
      let content = UNMutableNotificationContent()
      content.title = "New Journal entry 📌"
      content.body = location.description
      content.sound = UNNotificationSound.default
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
      let request = UNNotificationRequest(identifier: location.dateString, content: content, trigger: trigger)
      
      center.add(request, withCompletionHandler: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let location = locations.first else {
        return
      }
      
      AppDelegate.geoCoder.reverseGeocodeLocation(location) { placemarks, _ in
        if let place = placemarks?.first {
          let description = "Fake visit: \(place)"
          
          let fakeVisit = FakeVisit(coordinates: location.coordinate, arrivalDate: Date(), departureDate: Date())
          self.newVisitReceived(fakeVisit, description: description)
        }
      }
    }
  }

  final class FakeVisit: CLVisit {
    private let myCoordinates: CLLocationCoordinate2D
    private let myArrivalDate: Date
    private let myDepartureDate: Date

    override var coordinate: CLLocationCoordinate2D {
      return myCoordinates
    }
    
    override var arrivalDate: Date {
      return myArrivalDate
    }
    
    override var departureDate: Date {
      return myDepartureDate
    }
    
    init(coordinates: CLLocationCoordinate2D, arrivalDate: Date, departureDate: Date) {
      myCoordinates = coordinates
      myArrivalDate = arrivalDate
      myDepartureDate = departureDate
      super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    

    var logger: Logger?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let container = Container()
        
        container.register(AppStyle.self, name: "Day") {_ in AppDayStyle() }
        container.register(AppStyle.self, name: "Night") {_ in AppNightStyle() }
        container.register(EventManager.self) {_ in ListEventManager()}.inObjectScope(.container)
        Dependencies.container = container
        
        logger = Logger(eventManager: Dependencies.container.resolve(EventManager.self)!)
      
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

