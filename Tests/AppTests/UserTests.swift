@testable import App
import Vapor
import XCTest
import afterparty_models_swift

final class UserTests: XCTestCase {
  var app: Application!
  //var conn: PostgreSQLConnection!
  
  override func setUp() {
    try! Application.reset()
    app = try! Application.testable()
    //conn = try! app.newConnection(to: .psql).wait()
  }
  
  override func tearDown() {
    //conn.close()
    try? app.syncShutdownGracefully()
  }
  
  func testMockUsers() throws {
    let mockUsers = try app.getResponse(to: "/mock/users", decodeTo: [User].self)
    XCTAssertNotNil(mockUsers, "response to /mock/users should not be nil")
    XCTAssertTrue(mockUsers.count > 1, "should get more than one mock user")
  }
  
  func testBadUserRoute() throws {
    XCTAssertThrowsError(try app.getResponse(to: "mock/user", decodeTo: User.self), "Should not be able to get a user from a nonexistent route")
  }
  
  func testRandomUser() throws {
    let mockUser = try app.getResponse(to: "/mock/users/random", decodeTo: User.self)
    XCTAssertNotNil(mockUser, "response to /mock/users/random should not be nil")
  }
  
  func testSortedUsers() throws {
    let mockUsers = try app.getResponse(to: "/mock/users", decodeTo: [User].self)
    let sortedUsers = try app.getResponse(to: "/mock/users/sorted", decodeTo: [User].self)
    let mockUsersSorted = mockUsers.sorted { $0.email < $1.email }
    XCTAssertNotNil(mockUsers, "response to /mock/users should not be nil")
    XCTAssertNotNil(sortedUsers, "response to /mock/users/sorted should not be nil")
    XCTAssertTrue(mockUsers.count > 1, "should get more than one mock user")
    XCTAssertTrue(sortedUsers.count > 1, "should get more than one sorted user")
    XCTAssertEqual(mockUsers.count, mockUsersSorted.count, "pre sorted array should equal post sorted array")
  }
  
  static let allTests = [
    ("testMockUsers", testMockUsers,
     "testBadUserRoute", testBadUserRoute,
     "testRandomUser", testRandomUser,
     "testSortedUsers", testSortedUsers)
  ]
}
