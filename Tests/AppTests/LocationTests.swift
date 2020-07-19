@testable import App
import Vapor
import XCTest
import afterparty_models_swift

final class LocationTests: XCTestCase {
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
  
  func testMockLocations() throws {
    let mockLocations = try app.getResponse(to: "/mock/locations", decodeTo: [Location].self)
    XCTAssertNotNil(mockLocations, "response to /mock/locations should not be nil")
    XCTAssertTrue(mockLocations.count > 1, "should get more than one mock location")
  }
  
  func testBadLocationRoute() throws {
    XCTAssertThrowsError(try app.getResponse(to: "mock/location", decodeTo: Location.self), "Should not be able to get a location from a nonexistent route")
  }
  
  func testRandomLocation() throws {
    let mockLocation = try app.getResponse(to: "/mock/locations/random", decodeTo: Location.self)
    XCTAssertNotNil(mockLocation, "response to /mock/locations/random should not be nil")
  }
  
  func testSortedLocations() throws {
    let mockLocations = try app.getResponse(to: "/mock/locations", decodeTo: [Location].self)
    let sortedLocations = try app.getResponse(to: "/mock/locations/sorted", decodeTo: [Location].self)
    let mockLocationsSorted = mockLocations.sorted { $0.latitude < $1.latitude }
    XCTAssertNotNil(mockLocations, "response to /mock/locations should not be nil")
    XCTAssertNotNil(sortedLocations, "response to /mock/locations/sorted should not be nil")
    XCTAssertTrue(mockLocations.count > 1, "should get more than one mock location")
    XCTAssertTrue(sortedLocations.count > 1, "should get more than one sorted location")
    XCTAssertEqual(mockLocations.count, mockLocationsSorted.count, "pre sorted array should equal post sorted array")
  }
  
  static let allTests = [
    ("testMockLocations", testMockLocations,
     "testBadLocationRoute", testBadLocationRoute,
     "testRandomLocation", testRandomLocation,
     "testSortedLocations", testSortedLocations)
  ]
}
