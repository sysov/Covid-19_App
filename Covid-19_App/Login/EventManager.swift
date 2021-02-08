import Foundation

protocol EventManager {
    func subscribe(listener: Listener)
    func notify()
}
