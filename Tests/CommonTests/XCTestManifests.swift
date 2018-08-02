import XCTest

extension FacetTests {
    static let __allTests = [
        ("testConstrainingFacetSetInclusion", testConstrainingFacetSetInclusion),
        ("testFundamentalFacetSetInclusion", testFundamentalFacetSetInclusion),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FacetTests.__allTests),
    ]
}
#endif
