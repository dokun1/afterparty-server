import Vapor
import afterparty_models_swift

final class UserController {
  /// Returns a list of all `Todo`s.
  func index(_ req: Request) throws -> [User] {
    return MockData.participants
  }
}
