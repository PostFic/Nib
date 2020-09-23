import XCTest
import XSD
import XSDRegularExpressions

func anchoredRegularExpression(_ pattern: String)
	-> NSRegularExpression
{ return try! NSRegularExpression(pattern: "^\(pattern)$") }

final class XSDTestRegularExpressions: XCTestCase {

	func testRegularExpressionNilInvalid() {
		XCTAssertNil(XSD.RegularExpression("("))
	}

	func testRegularExpressionEscapesQuantifierModifiers() {
		XCTAssertEqual(
			XSD.RegularExpression("X*?X*+")!.nsRegularExpression,
			anchoredRegularExpression("X*\\?X*\\+")
		)
	}

	func testRegularExpressionEscapesNonCapturingParens() {
		XCTAssertEqual(
			XSD.RegularExpression("(?:)")!.nsRegularExpression,
			anchoredRegularExpression("(\\?:)")
		)
	}

	func testRegularExpressionThrowsUnsupportedEscapes() {
		for char in ["aAbBeEfGNQuUxXzZ0123456789"] {
			XCTAssertNil(XSD.RegularExpression("\\\(char)"))
		}
	}

	func testRegularExpressionEscapesAnchors() {
		XCTAssertEqual(
			XSD.RegularExpression("^^$$")!.nsRegularExpression,
			anchoredRegularExpression(#"\^^$\$"#)
		)
	}

	func testRegularExpressionReplacesDots() {
		XCTAssertEqual(
			XSD.RegularExpression(".")!.nsRegularExpression,
			anchoredRegularExpression(#"[^\n\r]"#)
		)
	}

	func testRegularExpressionDoesntHandleEscaped() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\."#)!.nsRegularExpression,
			anchoredRegularExpression(#"\."#)
		)
	}

	func testRegularExpressionHandlesVeryUnescaped() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\\\\\\."#)!.nsRegularExpression,
			anchoredRegularExpression(#"\\\\\\[^\n\r]"#)
		)
	}

	func testRegularExpressionReplacesLowercaseSEscape() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\s"#)!.nsRegularExpression,
			anchoredRegularExpression(#"[\x20\t\n\r]"#)
		)
	}

	func testRegularExpressionReplacesUppercaseSEscape() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\S"#)!.nsRegularExpression,
			anchoredRegularExpression(#"[^\x20\t\n\r]"#)
		)
	}

	func testRegularExpressionReplacesLowercaseIEscape() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\i"#)!.nsRegularExpression,
			anchoredRegularExpression("""
				[:A-Z_a-z\
				\\xC0-\\xD6\
				\\xD8-\\xF6\
				\\xF8-\\x{2FF}\
				\\x{370}-\\x{37D}\
				\\x{37F}-\\x{1FFF}\
				\\x{200C}-\\x{200D}\
				\\x{2070}-\\x{218F}\
				\\x{2C00}-\\x{2FEF}\
				\\x{3001}-\\x{D7FF}\
				\\x{F900}-\\x{FDCF}\
				\\x{FDF0}-\\x{FFFD}\
				\\x{10000}-\\x{EFFFF}]
				""")
		)
	}

	func testRegularExpressionReplacesUppercaseIEscape() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\I"#)!.nsRegularExpression,
			anchoredRegularExpression("""
				[^:A-Z_a-z\
				\\xC0-\\xD6\
				\\xD8-\\xF6\
				\\xF8-\\x{2FF}\
				\\x{370}-\\x{37D}\
				\\x{37F}-\\x{1FFF}\
				\\x{200C}-\\x{200D}\
				\\x{2070}-\\x{218F}\
				\\x{2C00}-\\x{2FEF}\
				\\x{3001}-\\x{D7FF}\
				\\x{F900}-\\x{FDCF}\
				\\x{FDF0}-\\x{FFFD}\
				\\x{10000}-\\x{EFFFF}]
				""")
		)
	}

	func testRegularExpressionReplacesLowercaseCEscape() {
		XCTAssertEqual(
			XSD.RegularExpression("\\c")!.nsRegularExpression,
			anchoredRegularExpression("""
				[:A-Z_a-z\
				\\xC0-\\xD6\
				\\xD8-\\xF6\
				\\xF8-\\x{2FF}\
				\\x{370}-\\x{37D}\
				\\x{37F}-\\x{1FFF}\
				\\x{200C}-\\x{200D}\
				\\x{2070}-\\x{218F}\
				\\x{2C00}-\\x{2FEF}\
				\\x{3001}-\\x{D7FF}\
				\\x{F900}-\\x{FDCF}\
				\\x{FDF0}-\\x{FFFD}\
				\\x{10000}-\\x{EFFFF}\
				\\-\\.\
				0-9\
				\\xB7\
				\\x{0300}-\\x{036F}\
				\\x{203F}-\\x{2040}]
				"""
			)
		)
	}

	func testRegularExpressionReplacesUppercaseCEscape() {
		XCTAssertEqual(
			XSD.RegularExpression("\\C")!.nsRegularExpression,
			anchoredRegularExpression("""
				[^:A-Z_a-z\
				\\xC0-\\xD6\
				\\xD8-\\xF6\
				\\xF8-\\x{2FF}\
				\\x{370}-\\x{37D}\
				\\x{37F}-\\x{1FFF}\
				\\x{200C}-\\x{200D}\
				\\x{2070}-\\x{218F}\
				\\x{2C00}-\\x{2FEF}\
				\\x{3001}-\\x{D7FF}\
				\\x{F900}-\\x{FDCF}\
				\\x{FDF0}-\\x{FFFD}\
				\\x{10000}-\\x{EFFFF}\
				\\-\\.\
				0-9\
				\\xB7\
				\\x{0300}-\\x{036F}\
				\\x{203F}-\\x{2040}]
				""")
		)
	}

	func testRegularExpressionReplacesLowercaseWEscape() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\w"#)!.nsRegularExpression,
			anchoredRegularExpression("""
				(?:(?![\\p{P}\\p{Z}\\p{C}])\
				[\\x00-\\x{10FFFF}])
				""")
		)
	}

	func testRegularExpressionReplacesUppercaseWEscape() {
		XCTAssertEqual(
			XSD.RegularExpression(#"\W"#)!.nsRegularExpression,
			anchoredRegularExpression(#"[\p{P}\p{Z}\p{C}]"#)
		)
	}

	func testRegularExpressionReplacesSubtractions() {
		XCTAssertEqual(
			XSD.RegularExpression("[A-Z-[QZ]]")!.nsRegularExpression,
			anchoredRegularExpression("(?:(?![QZ])[A-Z])")
		)
	}

	func textRegularExpressionOnlyHasXMLChars() {
		XCTAssertNil(XSD.RegularExpression("\u{FFFF}"))
	}
}
