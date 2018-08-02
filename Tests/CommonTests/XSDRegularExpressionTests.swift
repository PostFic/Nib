import XCTest
@testable import Common

final class XSDRegularExpressionTests: XCTestCase {

	/// Tests to ensure that the default implementations of `Relatable` methods behave as expected.
	func testRegularExpressionIsAnchored() {
		let regExp = try! XSDRegularExpression(".")
		XCTAssert(regExp.pattern.hasPrefix("^"))
		XCTAssert(regExp.pattern.hasSuffix("$"))
	}

	/// Tests to ensure that the regular expression propogates errors.
	func testRegularExpressionErrorPropogation() {
		XCTAssertThrowsError(try! XSDRegularExpression("("))
	}

	/// Tests to ensure only XML characters are allowed in regular expressions.
	func textRegularExpressionOnlyHasXMLChars() {
		XCTAssertThrowsError(try! XSDRegularExpression("\u{FFFF}"))
	}
}
