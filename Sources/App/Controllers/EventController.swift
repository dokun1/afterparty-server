//
//  EventController.swift
//  Created by David Okun on 7/19/20.
//

import Foundation
import Vapor
import afterparty_models_swift

extension Event: Content { }

struct EventController: RouteCollection {
  func boot(router: Router) throws {
    let mockEventRoutes = router.grouped("mock", "events")
    mockEventRoutes.get(use: getAllMockHandler)
    mockEventRoutes.get("random", use: getRandomMockHandler)
    mockEventRoutes.get("sorted", use: getSortedMockHandler)
  }
  
  func getAllMockHandler(_ req: Request) throws -> [Event] {
    MockData.sampleEvents
  }
  
  func getRandomMockHandler(_ req: Request) throws -> Event {
    guard let randomEvent = MockData.sampleEvents.random else {
      throw Abort(.badRequest)
    }
    return randomEvent
  }
  
  func getSortedMockHandler(_ req: Request) throws -> [Event] {
    MockData.sampleEvents.sorted { $0.name < $1.name }
  }
}
