import XCTest
@testable import Common

func anchoredRegularExpression(_ pattern: String) -> NSRegularExpression {
	return try! NSRegularExpression(pattern: "^\(pattern)$")
}

final class XSDRegularExpressionTests: XCTestCase {

	/// Tests to ensure that the regular expression propogates errors.
	func testRegularExpressionErrorPropogation() {
		XCTAssertThrowsError(try XSDRegularExpression("("))
	}

	func testRegularExpressionEscapesQuantifierModifiers() {
		XCTAssertEqual(
			try! XSDRegularExpression("X*?X*+"),
			anchoredRegularExpression("X*\\?X*\\+")
		)
	}

	func testRegularExpressionEscapesNonCapturingParens() {
		XCTAssertEqual(
			try! XSDRegularExpression("(?:)"),
			anchoredRegularExpression("(\\?:)")
		)
	}

	func testRegularExpressionThrowsUnsupportedEscapes() {
		for char in ["aAbBeEfGNQuUxXzZ0123456789"] {
			XCTAssertThrowsError(
				try XSDRegularExpression("\\\(char)")
			)
		}
	}

	func testRegularExpressionEscapesAnchors() {
		XCTAssertEqual(
			try! XSDRegularExpression("^^$$"),
			anchoredRegularExpression("\\^^$\\$")
		)
	}

	func testRegularExpressionReplacesDots() {
		XCTAssertEqual(
			try! XSDRegularExpression("."),
			anchoredRegularExpression("[^\\n\\r]")
		)
	}

	func testRegularExpressionDoesntHandleEscaped() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\."),
			anchoredRegularExpression("\\.")
		)
	}

	func testRegularExpressionHandlesVeryUnescaped() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\\\\\\\\\\\."),
			anchoredRegularExpression("\\\\\\\\\\\\[^\\n\\r]")
		)
	}

	func testRegularExpressionReplacesLowercaseSEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\s"),
			anchoredRegularExpression("[\\x20\\t\\n\\r]")
		)
	}

	func testRegularExpressionReplacesUppercaseSEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\S"),
			anchoredRegularExpression("[^\\x20\\t\\n\\r]")
		)
	}

	func testRegularExpressionReplacesLowercaseIEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\i"),
			anchoredRegularExpression("[:A-Z_a-z\\xC0-\\xD6\\xD8-\\xF6\\xF8-\\x{2FF}\\x{370}-\\x{37D}\\x{37F}-\\x{1FFF}\\x{200C}-\\x{200D}\\x{2070}-\\x{218F}\\x{2C00}-\\x{2FEF}\\x{3001}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFFD}\\x{10000}-\\x{EFFFF}]")
		)
	}

	func testRegularExpressionReplacesUppercaseIEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\I"),
			anchoredRegularExpression("[^:A-Z_a-z\\xC0-\\xD6\\xD8-\\xF6\\xF8-\\x{2FF}\\x{370}-\\x{37D}\\x{37F}-\\x{1FFF}\\x{200C}-\\x{200D}\\x{2070}-\\x{218F}\\x{2C00}-\\x{2FEF}\\x{3001}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFFD}\\x{10000}-\\x{EFFFF}]")
		)
	}

	func testRegularExpressionReplacesLowercaseCEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\c"),
			anchoredRegularExpression("[:A-Z_a-z\\xC0-\\xD6\\xD8-\\xF6\\xF8-\\x{2FF}\\x{370}-\\x{37D}\\x{37F}-\\x{1FFF}\\x{200C}-\\x{200D}\\x{2070}-\\x{218F}\\x{2C00}-\\x{2FEF}\\x{3001}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFFD}\\x{10000}-\\x{EFFFF}\\-\\.0-9\\xB7\\x{0300}-\\x{036F}\\x{203F}-\\x{2040}]")
		)
	}

	func testRegularExpressionReplacesUppercaseCEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\C"),
			anchoredRegularExpression("[^:A-Z_a-z\\xC0-\\xD6\\xD8-\\xF6\\xF8-\\x{2FF}\\x{370}-\\x{37D}\\x{37F}-\\x{1FFF}\\x{200C}-\\x{200D}\\x{2070}-\\x{218F}\\x{2C00}-\\x{2FEF}\\x{3001}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFFD}\\x{10000}-\\x{EFFFF}\\-\\.0-9\\xB7\\x{0300}-\\x{036F}\\x{203F}-\\x{2040}]")
		)
	}

	func testRegularExpressionReplacesLowercaseWEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\w"),
			anchoredRegularExpression("(?:(?![\\p{P}\\p{Z}\\p{C}])[\\x00-\\x{10FFFF}])")
		)
	}

	func testRegularExpressionReplacesUppercaseWEscape() {
		XCTAssertEqual(
			try! XSDRegularExpression("\\W"),
			anchoredRegularExpression("[\\p{P}\\p{Z}\\p{C}]")
		)
	}

	func testRegularExpressionReplacesSubtractions() {
		XCTAssertEqual(
			try! XSDRegularExpression("[[A-Z]-[QZ]]"),
			anchoredRegularExpression("(?:(?![QZ])[A-Z])")
		)
	}

	/// Tests to ensure only XML characters are allowed in regular expressions.
	func textRegularExpressionOnlyHasXMLChars() {
		XCTAssertThrowsError(try XSDRegularExpression("\u{FFFF}"))
	}
}
