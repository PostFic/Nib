import Foundation
import XCTest
import XSD
import XSDLiterals
import XSDValues
import XSDMappings

func testRepresentation <V> (
	_ representation: String,
	_ value: V
) where
	V: XSDValue,
	V: XSDCanonicalMappable
{
	let mapping = V.LexicalRepresentation(representation)?.·lexicalMapping·
	XCTAssertNotNil(mapping)
	XCTAssertTrue(mapping! === value)
}

final class XSDTestLexicalMappings: XCTestCase {

	func testStringValueLexicalMapping () {
		testRepresentation("\u{10000}", "\u{10000}" as XSD.StringValue)
	}

	func testBooleanValueLexicalMapping () {
		testRepresentation("true", true as XSD.BooleanValue)
		testRepresentation("false", false as XSD.BooleanValue)
		testRepresentation("1", true as XSD.BooleanValue)
		testRepresentation("0", false as XSD.BooleanValue)
	}

	func testDecimalValueLexicalMapping () {
		testRepresentation("00", 0 as XSD.DecimalValue)
		testRepresentation("+00", 0 as XSD.DecimalValue)
		testRepresentation("-00", 0 as XSD.DecimalValue)
		testRepresentation("00.", 0 as XSD.DecimalValue)
		testRepresentation("+00.", 0 as XSD.DecimalValue)
		testRepresentation("-00.", 0 as XSD.DecimalValue)
		testRepresentation("00.00", 0 as XSD.DecimalValue)
		testRepresentation("+00.00", 0 as XSD.DecimalValue)
		testRepresentation("-00.00", 0 as XSD.DecimalValue)
		testRepresentation(".00", 0 as XSD.DecimalValue)
		testRepresentation("+.00", 0 as XSD.DecimalValue)
		testRepresentation("-.00", 0 as XSD.DecimalValue)
		testRepresentation(
			"0123456789.9876543210",
			XSD.DecimalValue(
				exactly: Decimal(
					string: "123456789.987654321"
				)!
			)!
		)
		testRepresentation(
			"+0123456789.9876543210",
			XSD.DecimalValue(
				exactly: Decimal(
					string: "123456789.987654321"
				)!
			)!
		)
		testRepresentation(
			"-0123456789.9876543210",
			XSD.DecimalValue(
				exactly: Decimal(
					string: "-123456789.987654321"
				)!
			)!
		)
	}

	func testFloatValueLexicalMapping () {
		testRepresentation("00", 0 as XSD.FloatValue)
		testRepresentation("+00", 0 as XSD.FloatValue)
		testRepresentation("-00", -0.0 as XSD.FloatValue)
		testRepresentation("00.", 0 as XSD.FloatValue)
		testRepresentation("00.00", 0 as XSD.FloatValue)
		testRepresentation(".00", 0 as XSD.FloatValue)
		testRepresentation("+00.00", 0 as XSD.FloatValue)
		testRepresentation("-00.00", -0.0 as XSD.FloatValue)
		testRepresentation("00e00", 0 as XSD.FloatValue)
		testRepresentation(".00E00", 0 as XSD.FloatValue)
		testRepresentation("00.00e00", 0 as XSD.FloatValue)
		testRepresentation("+00.00e00", 0 as XSD.FloatValue)
		testRepresentation("-00.00e00", -0.0 as XSD.FloatValue)
		testRepresentation("012.340e05", 1234000 as XSD.FloatValue)
		testRepresentation("+012.340e05", 1234000 as XSD.FloatValue)
		testRepresentation("-012.340e05", -1234000 as XSD.FloatValue)
		testRepresentation(
			"INF",
			XSD.FloatValue(
				exactly: .positiveInfinity
			)!
		)
		testRepresentation(
			"+INF",
			XSD.FloatValue(
				exactly: .positiveInfinity
			)!
		)
		testRepresentation(
			"-INF",
			XSD.FloatValue(
				exactly: .negativeInfinity
			)!
		)
		testRepresentation(
			"NaN",
			XSD.FloatValue(
				exactly: .notANumber
			)!
		)
	}

	func testDoubleValueLexicalMapping () {
		testRepresentation("00", 0 as XSD.DoubleValue)
		testRepresentation("+00", 0 as XSD.DoubleValue)
		testRepresentation("-00", -0.0 as XSD.DoubleValue)
		testRepresentation("00.", 0 as XSD.DoubleValue)
		testRepresentation("00.00", 0 as XSD.DoubleValue)
		testRepresentation(".00", 0 as XSD.DoubleValue)
		testRepresentation("+00.00", 0 as XSD.DoubleValue)
		testRepresentation("-00.00", -0.0 as XSD.DoubleValue)
		testRepresentation("00e00", 0 as XSD.DoubleValue)
		testRepresentation(".00E00", 0 as XSD.DoubleValue)
		testRepresentation("00.00e00", 0 as XSD.DoubleValue)
		testRepresentation("+00.00e00", 0 as XSD.DoubleValue)
		testRepresentation("-00.00e00", -0.0 as XSD.DoubleValue)
		testRepresentation(
			"012.340e050",
			XSD.DoubleValue(
				exactly: Decimal(
					sign: .plus,
					exponent: 48,
					significand: 1234
				)
			)!
		)
		testRepresentation(
			"+012.340e050",
			XSD.DoubleValue(
				exactly: Decimal(
					sign: .plus,
					exponent: 48,
					significand: 1234
				)
			)!
		)
		testRepresentation(
			"-012.340e050",
			XSD.DoubleValue(
				exactly: Decimal(
					sign: .minus,
					exponent: 48,
					significand: 1234
				)
			)!
		)
		testRepresentation(
			"INF",
			XSD.DoubleValue(
				exactly: .positiveInfinity
			)!
		)
		testRepresentation(
			"+INF",
			XSD.DoubleValue(
				exactly: .positiveInfinity
			)!
		)
		testRepresentation(
			"-INF",
			XSD.DoubleValue(
				exactly: .negativeInfinity
			)!
		)
		testRepresentation(
			"NaN",
			XSD.DoubleValue(
				exactly: .notANumber
			)!
		)
	}


	func testDurationValueLexicalMapping () {
		testRepresentation(
			"-P00Y00M00DT00H00M00.00S",
			XSD.DurationValue(
				sign: .plus,
				months: 0,
				seconds: 0
			)
		)
		testRepresentation(
			"-P9Y9M9DT9H9M9.99S",
			XSD.DurationValue(
				sign: .minus,
				months: 117,
				seconds: 810549.99
			)
		)
		testRepresentation(
			"PT.0S",
			XSD.DurationValue(
				sign: .plus,
				months: 0,
				seconds: 0
			)
		)
		testRepresentation(
			"-P0D",
			XSD.DurationValue(
				sign: .plus,
				months: 0,
				seconds: 0
			)
		)
		testRepresentation(
			"P0M",
			XSD.DurationValue(
				sign: .plus,
				months: 0,
				seconds: 0
			)
		)
	}

	func testDateTimeValueLexicalMapping () {
		testRepresentation("1972-12-31T00:00:00Z", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, 0))
		testRepresentation("0000-01-01T24:00:00Z", XSD.DateTimeValue(0, 1, 1, 24, 0, 0, 0))
		testRepresentation("-0000-01-01T23:59:59", XSD.DateTimeValue(0, 1, 1, 23, 59, 59))
		testRepresentation("19720-02-29T00:00:00", XSD.DateTimeValue(19720, 2, 29, 0, 0, 0))
		testRepresentation("1972-12-31T00:00:00.00Z", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, 0))
		testRepresentation("1972-12-31T00:00:00.01Z", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0.01, 0))
		testRepresentation("1972-12-31T00:00:00+00:00", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, 0))
		testRepresentation("1972-12-31T00:00:00-00:00", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, 0))
		testRepresentation("1972-12-31T00:00:00+13:59", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, 839))
		testRepresentation("1972-12-31T00:00:00-14:00", XSD.DateTimeValue(1972, 12, 31, 0, 0, 0, -840))
	}

	func testTimeValueLexicalMapping() {
		testRepresentation("24:00:00Z", XSD.TimeValue(24, 0, 0, 0))
		testRepresentation("23:59:59", XSD.TimeValue(23, 59, 59))
		testRepresentation("00:00:00", XSD.TimeValue(0, 0, 0))
		testRepresentation("00:00:00.00", XSD.TimeValue(0, 0, 0))
		testRepresentation("00:00:00.01", XSD.TimeValue(0, 0, 0.01))
		testRepresentation("00:00:00+00:00", XSD.TimeValue(0, 0, 0, 0))
		testRepresentation("00:00:00-00:00", XSD.TimeValue(0, 0, 0, 0))
		testRepresentation("00:00:00+13:59", XSD.TimeValue(0, 0, 0, 839))
		testRepresentation("00:00:00-13:59", XSD.TimeValue(0, 0, 0, -839))
		testRepresentation("00:00:00+14:00", XSD.TimeValue(0, 0, 0, 840))
		testRepresentation("00:00:00-14:00", XSD.TimeValue(0, 0, 0, -840))
	}

	func testDateValueLexicalMapping() {
		testRepresentation("1972-12-31Z", XSD.DateValue(1972, 12, 31, 0))
		testRepresentation("0000-01-01Z", XSD.DateValue(0, 1, 1, 0))
		testRepresentation("-0000-01-01", XSD.DateValue(0, 1, 1))
		testRepresentation("19720-02-29", XSD.DateValue(19720, 2, 29))
		testRepresentation("1972-12-31+00:00", XSD.DateValue(1972, 12, 31, 0))
		testRepresentation("1972-12-31-00:00", XSD.DateValue(1972, 12, 31, 0))
		testRepresentation("1972-12-31+13:59", XSD.DateValue(1972, 12, 31, 839))
		testRepresentation("1972-12-31-14:00", XSD.DateValue(1972, 12, 31, -840))
	}

	func testGYearMonthValueLexicalMapping() {
		testRepresentation("1972-12Z", XSD.GYearMonthValue(1972, 12, 0))
		testRepresentation("0000-01Z", XSD.GYearMonthValue(0, 1, 0))
		testRepresentation("-0000-01", XSD.GYearMonthValue(0, 1))
		testRepresentation("19720-02", XSD.GYearMonthValue(19720, 2))
		testRepresentation("1972-12+00:00", XSD.GYearMonthValue(1972, 12, 0))
		testRepresentation("1972-12-00:00", XSD.GYearMonthValue(1972, 12, 0))
		testRepresentation("1972-12+13:59", XSD.GYearMonthValue(1972, 12, 839))
		testRepresentation("1972-12-14:00", XSD.GYearMonthValue(1972, 12, -840))
	}

	func testGYearValueLexicalMapping() {
		testRepresentation("1972Z", XSD.GYearValue(1972, 0))
		testRepresentation("0000Z", XSD.GYearValue(0, 0))
		testRepresentation("-0000", XSD.GYearValue(0))
		testRepresentation("19720", XSD.GYearValue(19720))
		testRepresentation("1972+00:00", XSD.GYearValue(1972, 0))
		testRepresentation("1972-00:00", XSD.GYearValue(1972, 0))
		testRepresentation("1972+13:59", XSD.GYearValue(1972, 839))
		testRepresentation("1972-14:00", XSD.GYearValue(1972, -840))
	}

	func testGMonthDayValueLexicalMapping() {
		testRepresentation("--12-31Z", XSD.GMonthDayValue(12, 31, 0))
		testRepresentation("--01-01Z", XSD.GMonthDayValue(1, 1, 0))
		testRepresentation("--01-01", XSD.GMonthDayValue(1, 1))
		testRepresentation("--02-29", XSD.GMonthDayValue(2, 29))
		testRepresentation("--12-31+00:00", XSD.GMonthDayValue(12, 31, 0))
		testRepresentation("--12-31-00:00", XSD.GMonthDayValue(12, 31, 0))
		testRepresentation("--12-31+13:59", XSD.GMonthDayValue(12, 31, 839))
		testRepresentation("--12-31-14:00", XSD.GMonthDayValue(12, 31, -840))
	}

	func testGDayValueLexicalMapping() {
		testRepresentation("---31Z", XSD.GDayValue(31, 0))
		testRepresentation("---01Z", XSD.GDayValue(1, 0))
		testRepresentation("---01", XSD.GDayValue(1))
		testRepresentation("---31+00:00", XSD.GDayValue(31, 0))
		testRepresentation("---31-00:00", XSD.GDayValue(31, 0))
		testRepresentation("---31+13:59", XSD.GDayValue(31, 839))
		testRepresentation("---31-14:00", XSD.GDayValue(31, -840))
	}

	func testGMonthValueLexicalMapping() {
		testRepresentation("--12Z", XSD.GMonthValue(12, 0))
		testRepresentation("--01Z", XSD.GMonthValue(1, 0))
		testRepresentation("--01", XSD.GMonthValue(1, nil))
		testRepresentation("--12+00:00", XSD.GMonthValue(12, 0))
		testRepresentation("--12-00:00", XSD.GMonthValue(12, 0))
		testRepresentation("--12+13:59", XSD.GMonthValue(12, 839))
		testRepresentation("--12-14:00", XSD.GMonthValue(12, -840))
	}

	func testHexBinaryValueLexicalMapping() {
		testRepresentation("0FB7", XSD.HexBinaryValue([0x0F, 0xB7]))
		testRepresentation("800bea", XSD.HexBinaryValue([0x80, 0x0B, 0xEA]))
	}

	func testBase64BinaryValueLexicalMapping() {
		testRepresentation(
			"KiBi1024",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi1024"
				)!
			)
		)
		testRepresentation(
			"KiBiBAo=",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBiBAo="
				)!
			)
		)
		testRepresentation(
			"KiBiBA==",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBiBA=="
				)!
			)
		)
		testRepresentation(
			"K iBi",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi"
				)!
			)
		)
		testRepresentation(
			"Ki Bi",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi"
				)!
			)
		)
		testRepresentation(
			"KiB i",
			XSD.Base64BinaryValue(
				Data(
					base64Encoded: "KiBi"
				)!
			)
		)
	}

}
