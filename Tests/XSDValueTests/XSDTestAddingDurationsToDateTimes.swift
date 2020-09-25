import XCTest
import XSD
import XSDValues

final class XSDTestAddingDurationsToDateTimes: XCTestCase {

	func testForExampleRow1() {
		XCTAssertEqual(
			XSD.·dateTimePlusDuration·(
				XSD.DurationValue("P1Y3M5DT7H10M3.3S")!,
				XSD.DateTimeValue("2000-01-12T12:13:14Z")!
			),
			XSD.DateTimeValue("2001-04-17T19:23:17.3Z")!
		)
	}

	func testForExampleRow2() {
		XCTAssertEqual(
			XSD.·dateTimePlusDuration·(
				XSD.DurationValue("-P3M")!,
				XSD.GYearMonthValue("2000-01")!
			),
			XSD.GYearMonthValue("1999-10")!
		)
	}

	func testForExampleRow3() {
		XCTAssertEqual(
			XSD.·dateTimePlusDuration·(
				XSD.DurationValue("PT33H")!,
				XSD.DateValue("2000-01-12")!
			),
			XSD.DateValue("2000-01-13")!
		)
	}

	func testForExamplePoint1() {
		let lhs = XSD.DateValue("2000-03-30")!
			+ XSD.DurationValue("P1D")!
			+ XSD.DurationValue("P1M")!
		let rhs = XSD.DateValue("2000-04-30")!
		XCTAssertEqual(lhs, rhs)
	}

	func testForExamplePoint2() {
		let lhs = XSD.DateValue("2000-03-30")!
			+ XSD.DurationValue("P1M")!
			+ XSD.DurationValue("P1D")!
		let rhs: XSD.DateValue = XSD.DateValue("2000-05-01")!
		XCTAssertEqual(lhs, rhs)
	}

}
