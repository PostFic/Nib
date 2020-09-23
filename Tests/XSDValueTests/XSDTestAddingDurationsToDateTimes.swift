import XCTest
import XSD
import XSDValues

final class XSDTestAddingDurationsToDateTimes: XCTestCase {

	func testForExampleRow1() {
		XCTAssertEqual(
			XSD.·dateTimePlusDuration·(
				"P1Y3M5DT7H10M3.3S",
				"2000-01-12T12:13:14Z" as XSD.DateTimeValue
			),
			"2001-04-17T19:23:17.3Z"
		)
	}

	func testForExampleRow2() {
		XCTAssertEqual(
			XSD.·dateTimePlusDuration·(
				"-P3M",
				"2000-01" as XSD.GYearMonthValue
			),
			"1999-10"
		)
	}

	func testForExampleRow3() {
		XCTAssertEqual(
			XSD.·dateTimePlusDuration·(
				"PT33H",
				"2000-01-12" as XSD.DateValue
			),
			"2000-01-13"
		)
	}

	func testForExamplePoint1() {
		let lhs = "2000-03-30" as XSD.DateValue + "P1D" + "P1M"
		let rhs: XSD.DateValue = "2000-04-30"
		XCTAssertEqual(lhs, rhs)
	}

	func testForExamplePoint2() {
		let lhs = "2000-03-30" as XSD.DateValue + "P1M" + "P1D"
		let rhs: XSD.DateValue = "2000-05-01"
		XCTAssertEqual(lhs, rhs)
	}

}
