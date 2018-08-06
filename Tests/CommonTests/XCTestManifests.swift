import XCTest

extension FacetTests {
    static let __allTests = [
        ("testConstrainingFacetSetInclusion", testConstrainingFacetSetInclusion),
        ("testFundamentalFacetSetInclusion", testFundamentalFacetSetInclusion),
    ]
}

extension XSDRegularExpressionTests {
    static let __allTests = [
        ("testRegularExpressionErrorPropogation", testRegularExpressionErrorPropogation),
        ("testRegularExpressionIsAnchored", testRegularExpressionIsAnchored),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FacetTests.__allTests),
        testCase(XSDRegularExpressionTests.__allTests),
    ]
}
#endif