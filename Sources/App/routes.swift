import Vapor
import afterparty_models_swift


/// Register your application's routes here.
public func routes(_ router: Router) throws {
  let userController = UserController()
  try router.register(collection: userController)
  
  let eventController = EventController()
  try router.register(collection: eventController)
  
  let locationController = LocationController()
  try router.register(collection: locationController)
}
