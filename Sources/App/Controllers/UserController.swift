//
//  UserController.swift
//  Created by David Okun on 7/19/20.
//

import Foundation
import Vapor
import afterparty_models_swift

extension User: Content { }

struct UserController: RouteCollection {
  func boot(router: Router) throws {
    let mockUserRoutes = router.grouped("mock", "users")
    mockUserRoutes.get(use: getAllMockHandler)
    mockUserRoutes.get("random", use: getRandomMockHandler)
    mockUserRoutes.get("sorted", use: getSortedMockHandler)
  }
  
  func getAllMockHandler(_ req: Request) throws -> [User] {
    MockData.participants
  }
  
  func getRandomMockHandler(_ req: Request) throws -> User {
    guard let randomUser = MockData.participants.random else {
      throw Abort(.badRequest)
    }
    return randomUser
  }
  
  func getSortedMockHandler(_ req: Request) throws -> [User] {
    MockData.participants.sorted { $0.email < $1.email }
  }
}
