//
//  LocationController.swift
//  Created by David Okun on 7/19/20.
//

import Foundation
import Vapor
import afterparty_models_swift

extension Location: Content { }

struct LocationController: RouteCollection {
  func boot(router: Router) throws {
    let mockLocationRoutes = router.grouped("mock", "locations")
    mockLocationRoutes.get(use: getAllMockHandler)
    mockLocationRoutes.get("random", use: getRandomMockHandler)
    mockLocationRoutes.get("sorted", use: getSortedMockHandler)
  }
  
  func getAllMockHandler(_ req: Request) throws -> [Location] {
    MockData.southLocations
  }
  
  func getRandomMockHandler(_ req: Request) throws -> Location {
    guard let randomLocation = MockData.southLocations.random else {
      throw Abort(.badRequest)
    }
    return randomLocation
  }
  
  func getSortedMockHandler(_ req: Request) throws -> [Location] {
    MockData.southLocations.sorted { $0.latitude < $1.latitude }
  }
}
