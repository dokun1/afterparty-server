@testable import App
import Vapor
import XCTest
import afterparty_models_swift

final class EventTests: XCTestCase {
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
  
  func testMockEvents() throws {
    let mockEvents = try app.getResponse(to: "/mock/events", decodeTo: [Event].self)
    XCTAssertNotNil(mockEvents, "response to /mock/events should not be nil")
    XCTAssertTrue(mockEvents.count > 1, "should get more than one mock event")
  }
  
  func testBadEventRoute() throws {
    XCTAssertThrowsError(try app.getResponse(to: "mock/event", decodeTo: Event.self), "Should not be able to get an event from a nonexistent route")
  }
  
  func testRandomEvent() throws {
    let mockEvents = try app.getResponse(to: "/mock/events/random", decodeTo: Event.self)
    XCTAssertNotNil(mockEvents, "response to /mock/events/random should not be nil")
  }
  
  func testSortedEvents() throws {
    let mockEvents = try app.getResponse(to: "/mock/events", decodeTo: [Event].self)
    let sortedEvents = try app.getResponse(to: "/mock/events/sorted", decodeTo: [Event].self)
    let mockEventsSorted = mockEvents.sorted { $0.name < $1.name }
    XCTAssertNotNil(mockEvents, "response to /mock/events should not be nil")
    XCTAssertNotNil(sortedEvents, "response to /mock/events/sorted should not be nil")
    XCTAssertTrue(mockEvents.count > 1, "should get more than one mock event")
    XCTAssertTrue(sortedEvents.count > 1, "should get more than one sorted event")
    XCTAssertEqual(mockEvents.count, mockEventsSorted.count, "pre sorted array should equal post sorted array")
  }
  
  static let allTests = [
    ("testMockEvents", testMockEvents,
     "testBadEventRoute", testBadEventRoute,
     "testRandomEvent", testRandomEvent,
     "testSortedEvents", testSortedEvents)
  ]
}
