import Foundation

class Logger: Listener {
    init(eventManager: EventManager){
        eventManager.subscribe(listener: self)
    }
    func update() {
        print("Successfull logout")
    }
}
