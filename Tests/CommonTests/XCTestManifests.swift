import XCTest

extension FacetTests {
    static let __allTests = [
        ("testXSDConstrainingFacetSetInclusion", testXSDConstrainingFacetSetInclusion),
        ("testXSDFundamentalFacetSetInclusion", testXSDFundamentalFacetSetInclusion),
    ]
}

extension XSDRegularExpressionTests {
    static let __allTests = [
        ("testRegularExpressionDoesntHandleEscaped", testRegularExpressionDoesntHandleEscaped),
        ("testRegularExpressionErrorPropogation", testRegularExpressionErrorPropogation),
        ("testRegularExpressionEscapesAnchors", testRegularExpressionEscapesAnchors),
        ("testRegularExpressionEscapesNonCapturingParens", testRegularExpressionEscapesNonCapturingParens),
        ("testRegularExpressionEscapesQuantifierModifiers", testRegularExpressionEscapesQuantifierModifiers),
        ("testRegularExpressionHandlesVeryUnescaped", testRegularExpressionHandlesVeryUnescaped),
        ("testRegularExpressionReplacesDots", testRegularExpressionReplacesDots),
        ("testRegularExpressionReplacesLowercaseCEscape", testRegularExpressionReplacesLowercaseCEscape),
        ("testRegularExpressionReplacesLowercaseIEscape", testRegularExpressionReplacesLowercaseIEscape),
        ("testRegularExpressionReplacesLowercaseSEscape", testRegularExpressionReplacesLowercaseSEscape),
        ("testRegularExpressionReplacesLowercaseWEscape", testRegularExpressionReplacesLowercaseWEscape),
        ("testRegularExpressionReplacesSubtractions", testRegularExpressionReplacesSubtractions),
        ("testRegularExpressionReplacesUppercaseCEscape", testRegularExpressionReplacesUppercaseCEscape),
        ("testRegularExpressionReplacesUppercaseIEscape", testRegularExpressionReplacesUppercaseIEscape),
        ("testRegularExpressionReplacesUppercaseSEscape", testRegularExpressionReplacesUppercaseSEscape),
        ("testRegularExpressionReplacesUppercaseWEscape", testRegularExpressionReplacesUppercaseWEscape),
        ("testRegularExpressionThrowsUnsupportedEscapes", testRegularExpressionThrowsUnsupportedEscapes),
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
