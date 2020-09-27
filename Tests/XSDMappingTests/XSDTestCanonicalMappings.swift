import Foundation
import XCTest
import XSD
import XSDLiterals
import XSDValues
import XSDMappings

func testMapping <V> (
	_ mapping: String,
	_ value: V
) where
	V: XSDValue,
	V: XSDCanonicalMappable
{ XCTAssertEqual(mapping, String(value.·canonicalMapping·)) }

final class XSDTestCanonicalMappings: XCTestCase {

	func testStringValueCanonicalMapping () {
		testMapping("\u{10000}", "\u{10000}" as XSD.StringValue)
	}

	func testBooleanValueCanonicalMapping () {
		testMapping("true", true as XSD.BooleanValue)
		testMapping("false", false as XSD.BooleanValue)
	}

	func testDecimalValueCanonicalMapping () {
		testMapping("0", 0 as XSD.DecimalValue)
		testMapping(
			"123456789.987654321",
			XSD.DecimalValue(
				exactly: Decimal(
					string: "123456789.987654321"
				)!
			)!
		)
		testMapping(
			"-123456789.987654321",
			XSD.DecimalValue(
				exactly: Decimal(
					string: "-123456789.987654321"
				)!
			)!
		)
	}

	func testFloatValueCanonicalMapping () {
		testMapping("0.0E0", 0 as XSD.FloatValue)
		testMapping("-0.0E0", -0.0 as XSD.FloatValue)
		testMapping("1.234E6", 1234000 as XSD.FloatValue)
		testMapping("-1.234E6", -1234000 as XSD.FloatValue)
		testMapping(
			"INF",
			XSD.FloatValue(
				exactly: .positiveInfinity
			)!
		)
		testMapping(
			"-INF",
			XSD.FloatValue(
				exactly: .negativeInfinity
			)!
		)
		testMapping(
			"NaN",
			XSD.FloatValue(
				exactly: .notANumber
			)!
		)
	}

	func testDoubleValueCanonicalMapping () {
		testMapping("0.0E0", 0 as XSD.DoubleValue)
		testMapping("-0.0E0", -0.0 as XSD.DoubleValue)
		testMapping(
			"1.234E51",
			XSD.DoubleValue(
				exactly: Decimal(
					sign: .plus,
					exponent: 48,
					significand: 1234
				)
			)!
		)
		testMapping(
			"-1.234E51",
			XSD.DoubleValue(
				exactly: Decimal(
					sign: .minus,
					exponent: 48,
					significand: 1234
				)
			)!
		)
		testMapping(
			"INF",
			XSD.DoubleValue(
				exactly: .positiveInfinity
			)!
		)
		testMapping(
			"-INF",
			XSD.DoubleValue(
				exactly: .negativeInfinity
			)!
		)
		testMapping(
			"NaN",
			XSD.DoubleValue(
				exactly: .notANumber
			)!
		)
	}


	func testDurationValueCanonicalMapping () {
		testMapping(
			"PT0S",
			XSD.DurationValue(
				sign: .plus,
				months: 0,
				seconds: 0
			)
		)
		testMapping(
			"-P9Y9M9DT9H9M9.99S",
			XSD.DurationValue(
				sign: .minus,
				months: 117,
				seconds: 810549.99
			)
		)
	}

	func testDateTimeValueCanonicalMapping () {
		testMapping("1972-12-31T00:00:00Z", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, 0))
		testMapping("0000-01-02T00:00:00Z", XSD.DateTimeValue(0, 1, 1, 24, 0, 0, 0))
		testMapping("0000-01-01T23:59:59", XSD.DateTimeValue(0, 1, 1, 23, 59, 59))
		testMapping("19720-02-29T00:00:00", XSD.DateTimeValue(19720, 2, 29, 0, 0, 0))
		testMapping("1972-12-31T00:00:00.01Z", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0.01, 0))
		testMapping("1972-12-31T00:00:00+13:59", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, 839))
		testMapping("1972-12-31T00:00:00-14:00", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, -840))
	}

	func testTimeValueCanonicalMapping() {
		testMapping("00:00:00Z", XSD.TimeValue(24, 0, 0, 0))
		testMapping("23:59:59", XSD.TimeValue(23, 59, 59))
		testMapping("00:00:00", XSD.TimeValue(0, 0, 0))
		testMapping("00:00:00.01", XSD.TimeValue(0, 0, 0.01))
		testMapping("00:00:00+13:59", XSD.TimeValue(0, 0, 0, 839))
		testMapping("00:00:00-13:59", XSD.TimeValue(0, 0, 0, -839))
		testMapping("00:00:00+14:00", XSD.TimeValue(0, 0, 0, 840))
		testMapping("00:00:00-14:00", XSD.TimeValue(0, 0, 0, -840))
	}

	func testDateValueCanonicalMapping() {
		testMapping("1972-12-31Z", XSD.DateValue(1972, 12, 31, 0))
		testMapping("0000-01-01Z", XSD.DateValue(0, 1, 1, 0))
		testMapping("0000-01-01", XSD.DateValue(0, 1, 1))
		testMapping("19720-02-29", XSD.DateValue(19720, 2, 29))
		testMapping("1972-12-31+13:59", XSD.DateValue(1972, 12, 31, 839))
		testMapping("1972-12-31-14:00", XSD.DateValue(1972, 12, 31, -840))
	}

	func testGYearMonthValueCanonicalMapping() {
		testMapping("1972-12Z", XSD.GYearMonthValue(1972, 12, 0))
		testMapping("0000-01Z", XSD.GYearMonthValue(0, 1, 0))
		testMapping("0000-01", XSD.GYearMonthValue(0, 1))
		testMapping("19720-02", XSD.GYearMonthValue(19720, 2))
		testMapping("1972-12+13:59", XSD.GYearMonthValue(1972, 12, 839))
		testMapping("1972-12-14:00", XSD.GYearMonthValue(1972, 12, -840))
	}

	func testGYearValueCanonicalMapping() {
		testMapping("1972Z", XSD.GYearValue(1972, 0))
		testMapping("0000Z", XSD.GYearValue(0, 0))
		testMapping("0000", XSD.GYearValue(0))
		testMapping("19720", XSD.GYearValue(19720))
		testMapping("1972+13:59", XSD.GYearValue(1972, 839))
		testMapping("1972-14:00", XSD.GYearValue(1972, -840))
	}

	func testGMonthDayValueCanonicalMapping() {
		testMapping("--12-31Z", XSD.GMonthDayValue(12, 31, 0))
		testMapping("--01-01Z", XSD.GMonthDayValue(1, 1, 0))
		testMapping("--01-01", XSD.GMonthDayValue(1, 1))
		testMapping("--02-29", XSD.GMonthDayValue(2, 29))
		testMapping("--12-31+13:59", XSD.GMonthDayValue(12, 31, 839))
		testMapping("--12-31-14:00", XSD.GMonthDayValue(12, 31, -840))
	}

	func testGDayValueCanonicalMapping() {
		testMapping("---31Z", XSD.GDayValue(31, 0))
		testMapping("---01Z", XSD.GDayValue(1, 0))
		testMapping("---01", XSD.GDayValue(1))
		testMapping("---31+13:59", XSD.GDayValue(31, 839))
		testMapping("---31-14:00", XSD.GDayValue(31, -840))
	}

	func testGMonthValueCanonicalMapping() {
		testMapping("--12Z", XSD.GMonthValue(12, 0))
		testMapping("--01Z", XSD.GMonthValue(1, 0))
		testMapping("--01", XSD.GMonthValue(1, nil))
		testMapping("--12+13:59", XSD.GMonthValue(12, 839))
		testMapping("--12-14:00", XSD.GMonthValue(12, -840))
	}

	func testHexBinaryValueCanonicalMapping() {
		testMapping("0FB7", XSD.HexBinaryValue([0x0F, 0xB7]))
		testMapping("800BEA", XSD.HexBinaryValue([0x80, 0x0B, 0xEA]))
	}

	func testBase64BinaryValueCanonicalMapping() {
		testMapping(
			"KiBi1024",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi1024"
				)!
			)
		)
		testMapping(
			"KiBiBAo=",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBiBAo="
				)!
			)
		)
		testMapping(
			"KiBiBA==",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBiBA=="
				)!
			)
		)
		testMapping(
			"KiBi",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi"
				)!
			)
		)
		testMapping(
			"KiBi",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi"
				)!
			)
		)
		testMapping(
			"KiBi",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi"
				)!
			)
		)
	}

}
