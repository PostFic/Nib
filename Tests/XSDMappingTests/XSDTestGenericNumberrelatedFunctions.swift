import XCTest
import XSD
import XSDLiterals
import XSDMappings

final class XSDTestGenericNumberrelatedFunctions:
	XCTestCase
{

	func testForExamplePoint1 () {
		XCTAssertEqual(XSD.·mod·(123.4567, 1), 0.4567)
		XCTAssertEqual(XSD.·div·(123.4567, 1), 123)
	}

	func testForExamplePoint2 ()
	{ XCTAssertEqual(Array(XSD.·digitRemainderSeq·(123).prefix(5)), [123, 12, 1, 0, 0]) }

	func testForExamplePoint3 ()
	{ XCTAssertEqual(Array(XSD.·digitSeq·(123).prefix(5)), [3, 2, 1, 0, 0]) }

	func testForExamplePoint4 ()
	{ XCTAssertEqual(XSD.·lastSignificantDigit·(XSD.·digitRemainderSeq·(123)), 2) }

	func testForExamplePoint5 ()
	{ XCTAssertEqual(XSD.·unsignedNoDecimalPtCanonicalMap·(123), XSD.unsignedNoDecimalPtNumeral("123")!) }

	func testForExamplePoint6 ()
	{ XCTAssertEqual(Array(XSD.·FractionDigitRemainderSeq·(0.4567).prefix(6)), [4.567, 5.67, 6.7, 7, 0, 0]) }

	func testForExamplePoint7 ()
	{ XCTAssertEqual(Array(XSD.·fractionDigitSeq·(0.4567).prefix(6)), [4, 5, 6, 7, 0, 0]) }

	func testForExamplePoint8 () {
		XCTAssertEqual(
			XSD.·lastSignificantDigit·(
				sequence(  //  see comment in Sources/XSDMappings/Canonical.swift
					state: XSD.·FractionDigitRemainderSeq·(0.4567).makeIterator()
				) { state in
					var nextState = state as! XSD.Sequence <XSD.DecimalNumber>.Iterator
					guard let S_i = nextState.next() else
					{ return nil }
					state = nextState
					return S_i == 0 ? 0 : 1
				}
			),
			3
		)
	}

	func testForExamplePoint9 ()
	{ XCTAssertEqual(XSD.·fractionDigitsCanonicalFragmentMap·(0.4567), XSD.fracFrag("4567")!) }

	func testForExamplePoint10 ()
	{ XCTAssertEqual(XSD.·unsignedDecimalPtCanonicalMap·(123.4567), XSD.unsignedDecimalPtNumeral("123.4567")!) }

}
