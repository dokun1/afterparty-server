#if !canImport(ObjectiveC)
import XCTest

extension EventTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EventTests = [
        ("testMockEvents", testMockEvents),
    ]
}

extension LocationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__LocationTests = [
        ("testMockLocations", testMockLocations),
    ]
}

extension UserTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__UserTests = [
        ("testMockUsers", testMockUsers),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EventTests.__allTests__EventTests),
        testCase(LocationTests.__allTests__LocationTests),
        testCase(UserTests.__allTests__UserTests),
    ]
}
#endif