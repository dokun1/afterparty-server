import Vapor
import afterparty_models_swift

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  // Basic "It works" example
  router.get { req in
    return "It works!"
  }
  
  // Basic "Hello, world!" example
  router.get("hello") { req in
    return "Hello, world! The date is: \(Date())"
  }
 
  router.get("hello", String.parameter) { req -> String in
    let name = try req.parameters.next(String.self)
    return "Hello \(name)! The date is: \(Date())"
  }
  
  router.get("mockUsers") { req -> String in
    let encoded = try JSONEncoder().encode(MockData.participants)
    return String(data: encoded, encoding: . utf8)!
  }
  
  router.get("mockEvents") { req -> String in
    let encoded = try JSONEncoder().encode(MockData.sampleEvents)
    return String(data: encoded, encoding: . utf8)!
  }
  
  router.get("mockLocations") { req -> String in
    let encoded = try JSONEncoder().encode(MockData.southLocations)
    return String(data: encoded, encoding: . utf8)!
  }
  
  // Example of configuring a controller
  let todoController = TodoController()
  router.get("todos", use: todoController.index)
  router.post("todos", use: todoController.create)
  router.delete("todos", Todo.parameter, use: todoController.delete)
  
//  let userController = UserController()
//  router.get("mockUsers", use: userController.mockIndex)
}
