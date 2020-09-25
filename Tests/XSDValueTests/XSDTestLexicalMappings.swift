import XCTest
import XSD
import XSDLiterals
import XSDValues
import Foundation

func testRepresentation<V: XSDValue>(
	_ representation: String,
	_ value: V
) {
	let mapping = V.LexicalRepresentation(
		representation
	)?.·lexicalMapping·
	XCTAssertNotNil(mapping)
	XCTAssertEqual(mapping!, value)
}

func testRepresentation<V: XSDNumberValue>(
	_ representation: String,
	_ value: V
) {
	let mapping = V.LexicalRepresentation(
		representation
	)?.·lexicalMapping·
	XCTAssertNotNil(mapping)
	if let specialValue = mapping!.specialValue {
		XCTAssertNotNil(value.specialValue)
		XCTAssertEqual(specialValue, value.specialValue!)
	} else { XCTAssertEqual(mapping!, value) }
}

final class XSDTestLexicalSpaces: XCTestCase {

	func testStringValueLexicalMapping() {
		testRepresentation("\u{10000}", "\u{10000}" as XSD.StringValue)
	}

	func testBooleanValueLexicalMapping() {
		testRepresentation("true", true as XSD.BooleanValue)
		testRepresentation("false", false as XSD.BooleanValue)
		testRepresentation("1", true as XSD.BooleanValue)
		testRepresentation("0", false as XSD.BooleanValue)
	}

	func testDecimalValueLexicalMapping() {
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
				exactly: Decimal(string: "123456789.987654321")!
			)!
		)
		testRepresentation(
			"+0123456789.9876543210",
			XSD.DecimalValue(
				exactly: Decimal(string: "123456789.987654321")!
			)!
		)
		testRepresentation(
			"-0123456789.9876543210",
			XSD.DecimalValue(
				exactly: Decimal(string: "-123456789.987654321")!
			)!
		)
	}

	func testFloatValueLexicalMapping() {
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
			XSD.FloatValue(exactly: .positiveInfinity)!
		)
		testRepresentation(
			"INF",
			XSD.FloatValue(exactly: .positiveInfinity)!
		)
		testRepresentation(
			"-INF",
			XSD.FloatValue(exactly: .negativeInfinity)!
		)
		testRepresentation(
			"NaN",
			XSD.FloatValue(exactly: .notANumber)!
		)
	}

	func testDoubleValueLexicalMapping() {
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
			XSD.DoubleValue(exactly: .positiveInfinity)!
		)
		testRepresentation(
			"INF",
			XSD.DoubleValue(exactly: .positiveInfinity)!
		)
		testRepresentation(
			"-INF",
			XSD.DoubleValue(exactly: .negativeInfinity)!
		)
		testRepresentation(
			"NaN",
			XSD.DoubleValue(exactly: .notANumber)!
		)
	}


	func testDurationValueLexicalMapping() {
		testRepresentation(
			"-P00Y00M00DT00H00M00.00S",
			XSD.DurationValue(months: 0, seconds: 0)!
		)
		testRepresentation(
			"-P9Y9M9DT9H9M9.99S",
			XSD.DurationValue(months: -117, seconds: -810549.99)!
		)
		testRepresentation(
			"PT.0S",
			XSD.DurationValue(months: 0, seconds: 0)!
		)
		testRepresentation(
			"-P0D",
			XSD.DurationValue(months: 0, seconds: 0)!
		)
		testRepresentation(
			"P0M",
			XSD.DurationValue(months: 0, seconds: 0)!
		)
	}

	func testDateTimeValueLexicalMapping() {
		testRepresentation(
			"1972-12-31T00:00:00Z",
			XSD.DateTimeValue(
				year: 1972,
				month: 12,
				day: 31,
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"0000-01-01T24:00:00Z",
			XSD.DateTimeValue(
				year: 0,
				month: 1,
				day: 1,
				hour: 24,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"-0000-01-01T23:59:59",
			XSD.DateTimeValue(
				year: 0,
				month: 1,
				day: 1,
				hour: 23,
				minute: 59,
				second: 59,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"19720-02-29T00:00:00",
			XSD.DateTimeValue(
				year: 19720,
				month: 2,
				day: 29,
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"1972-12-31T00:00:00.00Z",
			XSD.DateTimeValue(
				year: 1972,
				month: 12,
				day: 31,
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12-31T00:00:00.01Z",
			XSD.DateTimeValue(
				year: 1972,
				month: 12,
				day: 31,
				hour: 0,
				minute: 0,
				second: 0.01,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12-31T00:00:00+00:00",
			XSD.DateTimeValue(
				year: 1972,
				month: 12,
				day: 31,
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12-31T00:00:00-00:00",
			XSD.DateTimeValue(
				year: 1972,
				month: 12,
				day: 31,
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12-31T00:00:00+13:59",
			XSD.DateTimeValue(
				year: 1972,
				month: 12,
				day: 31,
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 839
			)!
		)
		testRepresentation(
			"1972-12-31T00:00:00-14:00",
			XSD.DateTimeValue(
				year: 1972,
				month: 12,
				day: 31,
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: -840
			)!
		)
	}

	func testTimeValueLexicalMapping() {
		testRepresentation(
			"24:00:00Z",
			XSD.TimeValue(
				hour: 24,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"23:59:59",
			XSD.TimeValue(
				hour: 23,
				minute: 59,
				second: 59,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"00:00:00",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"00:00:00.00",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"00:00:00.01",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0.01,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"00:00:00+00:00",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"00:00:00-00:00",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"00:00:00+13:59",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 839
			)!
		)
		testRepresentation(
			"00:00:00-13:59",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: -839
			)!
		)
		testRepresentation(
			"00:00:00+14:00",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: 840
			)!
		)
		testRepresentation(
			"00:00:00-14:00",
			XSD.TimeValue(
				hour: 0,
				minute: 0,
				second: 0,
				timezoneOffset: -840
			)!
		)
	}

	func testDateValueLexicalMapping() {
		testRepresentation(
			"1972-12-31Z",
			XSD.DateValue(
				year: 1972,
				month: 12,
				day: 31,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"0000-01-01Z",
			XSD.DateValue(
				year: 0,
				month: 1,
				day: 1,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"-0000-01-01",
			XSD.DateValue(
				year: 0,
				month: 1,
				day: 1,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"19720-02-29",
			XSD.DateValue(
				year: 19720,
				month: 2,
				day: 29,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"1972-12-31+00:00",
			XSD.DateValue(
				year: 1972,
				month: 12,
				day: 31,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12-31-00:00",
			XSD.DateValue(
				year: 1972,
				month: 12,
				day: 31,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12-31+13:59",
			XSD.DateValue(
				year: 1972,
				month: 12,
				day: 31,
				timezoneOffset: 839
			)!
		)
		testRepresentation(
			"1972-12-31-14:00",
			XSD.DateValue(
				year: 1972,
				month: 12,
				day: 31,
				timezoneOffset: -840
			)!
		)
	}

	func testGYearMonthValueLexicalMapping() {
		testRepresentation(
			"1972-12Z",
			XSD.GYearMonthValue(
				year: 1972,
				month: 12,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"0000-01Z",
			XSD.GYearMonthValue(
				year: 0,
				month: 1,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"-0000-01",
			XSD.GYearMonthValue(
				year: 0,
				month: 1,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"19720-02",
			XSD.GYearMonthValue(
				year: 19720,
				month: 2,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"1972-12+00:00",
			XSD.GYearMonthValue(
				year: 1972,
				month: 12,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12-00:00",
			XSD.GYearMonthValue(
				year: 1972,
				month: 12,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"1972-12+13:59",
			XSD.GYearMonthValue(
				year: 1972,
				month: 12,
				timezoneOffset: 839
			)!
		)
		testRepresentation(
			"1972-12-14:00",
			XSD.GYearMonthValue(
				year: 1972,
				month: 12,
				timezoneOffset: -840
			)!
		)
	}

	func testGYearValueLexicalMapping() {
		testRepresentation(
			"1972Z",
			XSD.GYearValue(year: 1972, timezoneOffset: 0)!
		)
		testRepresentation(
			"0000Z",
			XSD.GYearValue(year: 0, timezoneOffset: 0)!
		)
		testRepresentation(
			"-0000",
			XSD.GYearValue(year: 0, timezoneOffset: nil)!
		)
		testRepresentation(
			"19720",
			XSD.GYearValue(year: 19720, timezoneOffset: nil)!
		)
		testRepresentation(
			"1972+00:00",
			XSD.GYearValue(year: 1972, timezoneOffset: 0)!
		)
		testRepresentation(
			"1972-00:00",
			XSD.GYearValue(year: 1972, timezoneOffset: 0)!
		)
		testRepresentation(
			"1972+13:59",
			XSD.GYearValue(year: 1972, timezoneOffset: 839)!
		)
		testRepresentation(
			"1972-14:00",
			XSD.GYearValue(year: 1972, timezoneOffset: -840)!
		)
	}

	func testGMonthDayValueLexicalMapping() {
		testRepresentation(
			"--12-31Z",
			XSD.GMonthDayValue(
				month: 12,
				day: 31,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--01-01",
			XSD.GMonthDayValue(
				month: 1,
				day: 1,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--01-01",
			XSD.GMonthDayValue(
				month: 1,
				day: 1,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"--02-29",
			XSD.GMonthDayValue(
				month: 2,
				day: 29,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"--12-31+00:00",
			XSD.GMonthDayValue(
				month: 12,
				day: 31,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--12-31-00:00",
			XSD.GMonthDayValue(
				month: 12,
				day: 31,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--12-31+13:59",
			XSD.GMonthDayValue(
				month: 12,
				day: 31,
				timezoneOffset: 839
			)!
		)
		testRepresentation(
			"--12-31-14:00",
			XSD.GMonthDayValue(
				month: 12,
				day: 31,
				timezoneOffset: -840
			)!
		)
	}

	func testGDayValueLexicalMapping() {
		testRepresentation(
			"---31Z",
			XSD.GDayValue(day: 31, timezoneOffset: 0)!
		)
		testRepresentation(
			"---01Z",
			XSD.GDayValue(day: 1, timezoneOffset: 0)!
		)
		testRepresentation(
			"---01",
			XSD.GDayValue(day: 1, timezoneOffset: nil)!
		)
		testRepresentation(
			"---31+00:00",
			XSD.GDayValue(day: 31, timezoneOffset: 0)!
		)
		testRepresentation(
			"---31-00:00",
			XSD.GDayValue(day: 31, timezoneOffset: 0)!
		)
		testRepresentation(
			"---31+13:59",
			XSD.GDayValue(day: 31, timezoneOffset: 839)!
		)
		testRepresentation(
			"---31-14:00",
			XSD.GDayValue(day: 31, timezoneOffset: -840)!
		)
	}

	func testGMonthValueLexicalMapping() {
		testRepresentation(
			"--12Z",
			XSD.GMonthValue(
				month: 12,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--01Z",
			XSD.GMonthValue(
				month: 1,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--01",
			XSD.GMonthValue(
				month: 1,
				timezoneOffset: nil
			)!
		)
		testRepresentation(
			"--12+00:00",
			XSD.GMonthValue(
				month: 12,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--12-00:00",
			XSD.GMonthValue(
				month: 12,
				timezoneOffset: 0
			)!
		)
		testRepresentation(
			"--12+13:59",
			XSD.GMonthValue(
				month: 12,
				timezoneOffset: 839
			)!
		)
		testRepresentation(
			"--12-14:00",
			XSD.GMonthValue(
				month: 12,
				timezoneOffset: -840
			)!
		)
	}

	func testHexBinaryValueLexicalMapping() {
		testRepresentation("0FB7", XSD.HexBinaryValue([0x0F, 0xB7]))
		testRepresentation(
			"800bea",
			XSD.HexBinaryValue([0x80, 0x0B, 0xEA])
		)
	}

	func testBase64BinaryValueLexicalMapping() {
		testRepresentation(
			"KiBi1024",
			XSD.Base64BinaryValue(Data(base64Encoded: "KiBi1024")!)
		)
		testRepresentation(
			"KiBiBAo=",
			XSD.Base64BinaryValue(Data(base64Encoded: "KiBiBAo=")!)
		)
		testRepresentation(
			"KiBiBA==",
			XSD.Base64BinaryValue(Data(base64Encoded: "KiBiBA==")!)
		)
		testRepresentation(
			"K iBi",
			XSD.Base64BinaryValue(Data(base64Encoded: "KiBi")!)
		)
		testRepresentation(
			"Ki Bi",
			XSD.Base64BinaryValue(Data(base64Encoded: "KiBi")!)
		)
		testRepresentation(
			"KiB i",
			XSD.Base64BinaryValue(Data(base64Encoded: "KiBi")!)
		)
	}

}
