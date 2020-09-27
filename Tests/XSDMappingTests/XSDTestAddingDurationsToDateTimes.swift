import XCTest
import XSD
import XSDValues
import XSDMappings

final class XSDTestAddingDurationsToDateTimes:
	XCTestCase
{

	func testForExampleRow1 ()
	{ XCTAssertEqual(XSD.·dateTimePlusDuration·(XSD.DurationValue("P1Y3M5DT7H10M3.3S")!, XSD.DateTimeValue("2000-01-12T12:13:14Z")!), XSD.DateTimeValue("2001-04-17T19:23:17.3Z")!) }

	func testForExampleRow2 ()
	{ XCTAssertEqual(XSD.·dateTimePlusDuration·(XSD.DurationValue("-P3M")!, XSD.GYearMonthValue("2000-01")!), XSD.GYearMonthValue("1999-10")!) }

	func testForExampleRow3 ()
	{ XCTAssertEqual(XSD.·dateTimePlusDuration·(XSD.DurationValue("PT33H")!, XSD.DateValue("2000-01-12")!), XSD.DateValue("2000-01-13")!) }

	func testForExamplePoint1 ()
	{ XCTAssertEqual(XSD.DateValue("2000-03-30")! + XSD.DurationValue("P1D")! + XSD.DurationValue("P1M")!, XSD.DateValue("2000-04-30")!) }

	func testForExamplePoint2 ()
	{ XCTAssertEqual(XSD.DateValue("2000-03-30")! + XSD.DurationValue("P1M")! + XSD.DurationValue("P1D")!, XSD.DateValue("2000-05-01")!) }

}
