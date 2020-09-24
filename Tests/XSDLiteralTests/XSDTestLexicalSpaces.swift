import XCTest
import XSD
import XSDLiterals

final class XSDTestLexicalSpaces: XCTestCase {

	func testStringRep() {
		XCTAssertNotNil(XSD.stringRep("\u{10000}"))
		XCTAssertNil(XSD.stringRep("\u{FFFF}"))
	}

	func testBooleanRep() {
		XCTAssertNotNil(XSD.booleanRep("true"))
		XCTAssertNotNil(XSD.booleanRep("false"))
		XCTAssertNotNil(XSD.booleanRep("1"))
		XCTAssertNotNil(XSD.booleanRep("0"))
		XCTAssertNil(XSD.booleanRep("True"))
	}

	func testDecimalLexicalRep() {
		XCTAssertNotNil(XSD.decimalLexicalRep("+00"))
		XCTAssertNotNil(XSD.decimalLexicalRep("-.00"))
		XCTAssertNotNil(XSD.decimalLexicalRep("+00.00"))
		XCTAssertNil(XSD.decimalLexicalRep("+"))
		XCTAssertNil(XSD.decimalLexicalRep("."))
	}

	func testFloatRep() {
		XCTAssertNotNil(XSD.floatRep("+00"))
		XCTAssertNotNil(XSD.floatRep("-.00"))
		XCTAssertNotNil(XSD.floatRep("+00.00"))
		XCTAssertNotNil(XSD.floatRep("-00e00"))
		XCTAssertNotNil(XSD.floatRep("+.00E00"))
		XCTAssertNotNil(XSD.floatRep("-00.00e00"))
		XCTAssertNotNil(XSD.floatRep("+INF"))
		XCTAssertNotNil(XSD.floatRep("NaN"))
		XCTAssertNil(XSD.floatRep("+"))
		XCTAssertNil(XSD.floatRep("."))
		XCTAssertNil(XSD.floatRep("E"))
		XCTAssertNil(XSD.floatRep("00.00e00.00"))
		XCTAssertNil(XSD.floatRep("+NaN"))
	}

	func testDoubleRep() {
		XCTAssertNotNil(XSD.doubleRep("+00"))
		XCTAssertNotNil(XSD.doubleRep("-.00"))
		XCTAssertNotNil(XSD.doubleRep("+00.00"))
		XCTAssertNotNil(XSD.doubleRep("-00e00"))
		XCTAssertNotNil(XSD.doubleRep("+.00E00"))
		XCTAssertNotNil(XSD.doubleRep("-00.00e00"))
		XCTAssertNotNil(XSD.doubleRep("+INF"))
		XCTAssertNotNil(XSD.doubleRep("NaN"))
		XCTAssertNil(XSD.doubleRep("+"))
		XCTAssertNil(XSD.doubleRep("."))
		XCTAssertNil(XSD.doubleRep("E"))
		XCTAssertNil(XSD.doubleRep("00.00e00.00"))
		XCTAssertNil(XSD.doubleRep("+NaN"))
	}

	func testDuYearFrag() {
		XCTAssertNotNil(XSD.duYearFrag("00Y"))
		XCTAssertNil(XSD.duYearFrag("0"))
		XCTAssertNil(XSD.duYearFrag("Y"))
	}

	func testDuMonthFrag() {
		XCTAssertNotNil(XSD.duMonthFrag("00M"))
		XCTAssertNil(XSD.duMonthFrag("0"))
		XCTAssertNil(XSD.duMonthFrag("M"))
	}

	func testDuDayFrag() {
		XCTAssertNotNil(XSD.duDayFrag("00D"))
		XCTAssertNil(XSD.duDayFrag("0"))
		XCTAssertNil(XSD.duDayFrag("D"))
	}

	func testDuHourFrag() {
		XCTAssertNotNil(XSD.duHourFrag("00H"))
		XCTAssertNil(XSD.duHourFrag("0"))
		XCTAssertNil(XSD.duHourFrag("H"))
	}

	func testDuMinuteFrag() {
		XCTAssertNotNil(XSD.duMinuteFrag("00M"))
		XCTAssertNil(XSD.duMinuteFrag("0"))
		XCTAssertNil(XSD.duMinuteFrag("M"))
	}

	func testDuSecondFrag() {
		XCTAssertNotNil(XSD.duSecondFrag("00S"))
		XCTAssertNotNil(XSD.duSecondFrag(".00S"))
		XCTAssertNotNil(XSD.duSecondFrag("00.00S"))
		XCTAssertNil(XSD.duSecondFrag("0"))
		XCTAssertNil(XSD.duSecondFrag(".S"))
		XCTAssertNil(XSD.duSecondFrag("S"))
	}

	func testDuYearMonthFrag() {
		XCTAssertNotNil(XSD.duYearMonthFrag("00Y00M"))
		XCTAssertNil(XSD.duYearMonthFrag("0M0Y"))
		XCTAssertNil(XSD.duYearMonthFrag("0"))
		XCTAssertNil(XSD.duYearMonthFrag("M"))
	}

	func testDuTimeFrag() {
		XCTAssertNotNil(XSD.duTimeFrag("T00H00M00.00S"))
		XCTAssertNotNil(XSD.duDayTimeFrag("T.0S"))
		XCTAssertNil(XSD.duTimeFrag("T"))
		XCTAssertNil(XSD.duTimeFrag("T0M0H"))
		XCTAssertNil(XSD.duTimeFrag("0"))
		XCTAssertNil(XSD.duTimeFrag("TS"))
	}

	func testDuDayTimeFrag() {
		XCTAssertNotNil(XSD.duDayTimeFrag("00DT00H00M00.00S"))
		XCTAssertNotNil(XSD.duDayTimeFrag("00D"))
		XCTAssertNotNil(XSD.duDayTimeFrag("T.0S"))
		XCTAssertNil(XSD.duDayTimeFrag("T"))
		XCTAssertNil(XSD.duDayTimeFrag("T0D"))
		XCTAssertNil(XSD.duDayTimeFrag("T0M0H"))
		XCTAssertNil(XSD.duDayTimeFrag("0"))
		XCTAssertNil(XSD.duDayTimeFrag("TS"))
	}

	func testDurationLexicalRep() {
		XCTAssertNotNil(
			XSD.durationLexicalRep("-P00Y00M00DT00H00M00.00S")
		)
		XCTAssertNotNil(XSD.durationLexicalRep("PT.0S"))
		XCTAssertNotNil(XSD.durationLexicalRep("-P0D"))
		XCTAssertNotNil(XSD.durationLexicalRep("P0M"))
		XCTAssertNil(XSD.durationLexicalRep("-"))
		XCTAssertNil(XSD.durationLexicalRep("P"))
		XCTAssertNil(XSD.durationLexicalRep("0"))
		XCTAssertNil(XSD.durationLexicalRep("PY"))
		XCTAssertNil(XSD.durationLexicalRep("PTS"))
		XCTAssertNil(XSD.durationLexicalRep("+P0S"))
		XCTAssertNil(XSD.durationLexicalRep("P0MT"))
		XCTAssertNil(XSD.durationLexicalRep("PT0S0M"))
	}

	func testDateTimeLexicalRep() {
		XCTAssertNotNil(XSD.dateTimeLexicalRep("1972-12-31T00:00:00Z"))
		XCTAssertNotNil(XSD.dateTimeLexicalRep("0000-01-01T24:00:00Z"))
		XCTAssertNotNil(XSD.dateTimeLexicalRep("-0000-01-01T23:59:59"))
		XCTAssertNotNil(XSD.dateTimeLexicalRep("19720-02-29T00:00:00"))
		XCTAssertNotNil(
			XSD.dateTimeLexicalRep("1972-12-31T00:00:00.00Z")
		)
		XCTAssertNotNil(
			XSD.dateTimeLexicalRep("1972-12-31T00:00:00+00:00")
		)
		XCTAssertNotNil(
			XSD.dateTimeLexicalRep("1972-12-31T00:00:00-00:00")
		)
		XCTAssertNotNil(
			XSD.dateTimeLexicalRep("1972-12-31T00:00:00+13:59")
		)
		XCTAssertNotNil(
			XSD.dateTimeLexicalRep("1972-12-31T00:00:00-14:00")
		)
		XCTAssertNil(XSD.dateTimeLexicalRep("+1972-12-31T00:00:00"))
		XCTAssertNil(XSD.dateTimeLexicalRep("01972-12-31T00:00:00"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31T00:00:00."))
		XCTAssertNil(XSD.dateTimeLexicalRep("0000-00-00T00:00:00"))
		XCTAssertNil(XSD.dateTimeLexicalRep("9999-99-99T99:99:99"))
		XCTAssertNil(XSD.dateTimeLexicalRep("0000-04-31T00:00:00"))
		XCTAssertNil(XSD.dateTimeLexicalRep("0000-02-30T00:00:00"))
		XCTAssertNil(XSD.dateTimeLexicalRep("0001-02-29T00:00:00"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31T00:00:00z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31T00:00:00+14"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31"))
	}

	func testTimeLexicalRep() {
		XCTAssertNotNil(XSD.timeLexicalRep("24:00:00Z"))
		XCTAssertNotNil(XSD.timeLexicalRep("23:59:59"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00.00"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00.00+00:00"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00.00-00:00"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00+13:59"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00-13:59"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00+14:00"))
		XCTAssertNotNil(XSD.timeLexicalRep("00:00:00-14:00"))
		XCTAssertNil(XSD.timeLexicalRep("24:00:01"))
		XCTAssertNil(XSD.timeLexicalRep("99:99:99"))
		XCTAssertNil(XSD.timeLexicalRep("0:00:00"))
		XCTAssertNil(XSD.timeLexicalRep("00:00:00."))
		XCTAssertNil(XSD.timeLexicalRep("00:00:00z"))
		XCTAssertNil(XSD.timeLexicalRep("00:00:00+14"))
		XCTAssertNil(XSD.timeLexicalRep("00:00"))
	}

	func testDateLexicalRep() {
		XCTAssertNotNil(XSD.dateLexicalRep("1972-12-31Z"))
		XCTAssertNotNil(XSD.dateLexicalRep("0000-01-01Z"))
		XCTAssertNotNil(XSD.dateLexicalRep("-0000-01-01"))
		XCTAssertNotNil(XSD.dateLexicalRep("19720-02-29"))
		XCTAssertNotNil(XSD.dateLexicalRep("1972-12-31+00:00"))
		XCTAssertNotNil(XSD.dateLexicalRep("1972-12-31-00:00"))
		XCTAssertNotNil(XSD.dateLexicalRep("1972-12-31+13:59"))
		XCTAssertNotNil(XSD.dateLexicalRep("1972-12-31-14:00"))
		XCTAssertNil(XSD.dateLexicalRep("+1972-12-31"))
		XCTAssertNil(XSD.dateLexicalRep("01972-12-31"))
		XCTAssertNil(XSD.dateLexicalRep("0000-00-00"))
		XCTAssertNil(XSD.dateLexicalRep("9999-99-99"))
		XCTAssertNil(XSD.dateLexicalRep("0000-04-31"))
		XCTAssertNil(XSD.dateLexicalRep("0000-02-30"))
		XCTAssertNil(XSD.dateLexicalRep("0001-02-29"))
		XCTAssertNil(XSD.dateLexicalRep("1972-12-31z"))
		XCTAssertNil(XSD.dateLexicalRep("1972-12-31+14"))
	}

	func testGYearMonthLexicalRep() {
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("1972-12Z"))
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("0000-01Z"))
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("-0000-01"))
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("19720-02"))
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("1972-12+00:00"))
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("1972-12-00:00"))
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("1972-12+13:59"))
		XCTAssertNotNil(XSD.gYearMonthLexicalRep("1972-12-14:00"))
		XCTAssertNil(XSD.gYearMonthLexicalRep("+1972-12"))
		XCTAssertNil(XSD.gYearMonthLexicalRep("01972-12"))
		XCTAssertNil(XSD.gYearMonthLexicalRep("0000-00"))
		XCTAssertNil(XSD.gYearMonthLexicalRep("9999-99"))
		XCTAssertNil(XSD.gYearMonthLexicalRep("1972-12z"))
		XCTAssertNil(XSD.gYearMonthLexicalRep("1972-12+14"))
	}

	func testGYearLexicalRep() {
		XCTAssertNotNil(XSD.gYearLexicalRep("1972Z"))
		XCTAssertNotNil(XSD.gYearLexicalRep("0000Z"))
		XCTAssertNotNil(XSD.gYearLexicalRep("-0000"))
		XCTAssertNotNil(XSD.gYearLexicalRep("19720"))
		XCTAssertNotNil(XSD.gYearLexicalRep("1972+00:00"))
		XCTAssertNotNil(XSD.gYearLexicalRep("1972-00:00"))
		XCTAssertNotNil(XSD.gYearLexicalRep("1972+13:59"))
		XCTAssertNotNil(XSD.gYearLexicalRep("1972-14:00"))
		XCTAssertNil(XSD.gYearLexicalRep("+1972"))
		XCTAssertNil(XSD.gYearLexicalRep("01972"))
		XCTAssertNil(XSD.gYearLexicalRep("1972z"))
		XCTAssertNil(XSD.gYearLexicalRep("1972+14"))
	}

	func testGMonthDayLexicalRep() {
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--12-31Z"))
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--01-01Z"))
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--01-01"))
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--02-29"))
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--12-31+00:00"))
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--12-31-00:00"))
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--12-31+13:59"))
		XCTAssertNotNil(XSD.gMonthDayLexicalRep("--12-31-14:00"))
		XCTAssertNil(XSD.gMonthDayLexicalRep("-00-00"))
		XCTAssertNil(XSD.gMonthDayLexicalRep("-99-99"))
		XCTAssertNil(XSD.gMonthDayLexicalRep("-04-31"))
		XCTAssertNil(XSD.gMonthDayLexicalRep("-02-30"))
		XCTAssertNil(XSD.gMonthDayLexicalRep("02-29"))
		XCTAssertNil(XSD.gMonthDayLexicalRep("-12-31z"))
		XCTAssertNil(XSD.gMonthDayLexicalRep("-12-31+14"))
	}

	func testGDayLexicalRep() {
		XCTAssertNotNil(XSD.gDayLexicalRep("---31Z"))
		XCTAssertNotNil(XSD.gDayLexicalRep("---01Z"))
		XCTAssertNotNil(XSD.gDayLexicalRep("---01"))
		XCTAssertNotNil(XSD.gDayLexicalRep("---31+00:00"))
		XCTAssertNotNil(XSD.gDayLexicalRep("---31-00:00"))
		XCTAssertNotNil(XSD.gDayLexicalRep("---31+13:59"))
		XCTAssertNotNil(XSD.gDayLexicalRep("---31-14:00"))
		XCTAssertNil(XSD.gDayLexicalRep("---00"))
		XCTAssertNil(XSD.gDayLexicalRep("---99"))
		XCTAssertNil(XSD.gDayLexicalRep("---31z"))
		XCTAssertNil(XSD.gDayLexicalRep("---31+14"))
	}

	func testGMonthLexicalRep() {
		XCTAssertNotNil(XSD.gMonthLexicalRep("--12Z"))
		XCTAssertNotNil(XSD.gMonthLexicalRep("--01Z"))
		XCTAssertNotNil(XSD.gMonthLexicalRep("--01"))
		XCTAssertNotNil(XSD.gMonthLexicalRep("--12+00:00"))
		XCTAssertNotNil(XSD.gMonthLexicalRep("--12-00:00"))
		XCTAssertNotNil(XSD.gMonthLexicalRep("--12+13:59"))
		XCTAssertNotNil(XSD.gMonthLexicalRep("--12-14:00"))
		XCTAssertNil(XSD.gMonthLexicalRep("-00"))
		XCTAssertNil(XSD.gMonthLexicalRep("-99"))
		XCTAssertNil(XSD.gMonthLexicalRep("-12z"))
		XCTAssertNil(XSD.gMonthLexicalRep("-12+14"))
	}

	func testHexDigit() {}

	func testHexOctet() {}

	func testHexBinaryRep() {}

	func test·Base64Binary() {}

	func test·B64quad() {}

	func test·B64final() {}

	func test·B64finalquad() {}

	func test·Padded16() {}

	func test·Padded8() {}

	func test·B64() {}

	func test·B64char() {}

	func test·B16() {}

	func test·B16char() {}

	func test·B04() {}

	func test·B04char() {}

	func test·Canonical·base64Binary() {}

	func test·CanonicalQuad() {}

	func test·CanonicalPadded() {}

	func testYearMonthDurationLexicalRep() {}

	func testDayTimeLexicalRep() {}

	func testDateTimeStampLexicalRep() {}

	func testDigit() {}

	func testUnsignedNoDecimalPtNumeral() {}

	func testNoDecimalPtNumeral() {}

	func testFracFrag() {}

	func testUnsignedDecimalPtNumeral() {}

	func testUnsignedFullDecimalPtNumeral() {}

	func testDecimalPtNumeral() {}

	func testUnsignedScientificNotationNumeral() {}

	func testScientificNotationNumeral() {}

	func testMinimalNumericalSpecialRep() {}

	func testNumericalSpecialRep() {}

	func testYearFrag() {
		XCTAssertNotNil(XSD.yearFrag("0000"))
		XCTAssertNotNil(XSD.yearFrag("0001"))
		XCTAssertNotNil(XSD.yearFrag("-0000"))
		XCTAssertNotNil(XSD.yearFrag("-0001"))
		XCTAssertNotNil(XSD.yearFrag("-10000"))
		XCTAssertNotNil(XSD.yearFrag("99999"))
		XCTAssertNil(XSD.yearFrag("00000"))
		XCTAssertNil(XSD.yearFrag("+0001"))
		XCTAssertNil(XSD.yearFrag("1"))
		XCTAssertNil(XSD.yearFrag("-00001"))
		XCTAssertNil(XSD.yearFrag("00001"))
	}

	func testMonthFrag() {
		XCTAssertNotNil(XSD.monthFrag("01"))
		XCTAssertNotNil(XSD.monthFrag("10"))
		XCTAssertNotNil(XSD.monthFrag("12"))
		XCTAssertNil(XSD.monthFrag("00"))
		XCTAssertNil(XSD.monthFrag("010"))
		XCTAssertNil(XSD.monthFrag("1"))
		XCTAssertNil(XSD.monthFrag("13"))
		XCTAssertNil(XSD.monthFrag("20"))
	}

	func testDayFrag() {
		XCTAssertNotNil(XSD.dayFrag("01"))
		XCTAssertNotNil(XSD.dayFrag("10"))
		XCTAssertNotNil(XSD.dayFrag("22"))
		XCTAssertNotNil(XSD.dayFrag("31"))
		XCTAssertNil(XSD.dayFrag("00"))
		XCTAssertNil(XSD.dayFrag("010"))
		XCTAssertNil(XSD.dayFrag("1"))
		XCTAssertNil(XSD.dayFrag("32"))
		XCTAssertNil(XSD.dayFrag("40"))
	}

	func testHourFrag() {
		XCTAssertNotNil(XSD.hourFrag("00"))
		XCTAssertNotNil(XSD.hourFrag("01"))
		XCTAssertNotNil(XSD.hourFrag("10"))
		XCTAssertNotNil(XSD.hourFrag("23"))
		XCTAssertNil(XSD.hourFrag("010"))
		XCTAssertNil(XSD.hourFrag("1"))
		XCTAssertNil(XSD.hourFrag("24"))
		XCTAssertNil(XSD.hourFrag("32"))
	}

	func testMinuteFrag() {
		XCTAssertNotNil(XSD.minuteFrag("00"))
		XCTAssertNotNil(XSD.minuteFrag("01"))
		XCTAssertNotNil(XSD.minuteFrag("10"))
		XCTAssertNotNil(XSD.minuteFrag("22"))
		XCTAssertNotNil(XSD.minuteFrag("59"))
		XCTAssertNil(XSD.minuteFrag("010"))
		XCTAssertNil(XSD.minuteFrag("1"))
		XCTAssertNil(XSD.minuteFrag("60"))
		XCTAssertNil(XSD.minuteFrag("72"))
	}

	func testSecondFrag() {
		XCTAssertNotNil(XSD.secondFrag("00"))
		XCTAssertNotNil(XSD.secondFrag("01"))
		XCTAssertNotNil(XSD.secondFrag("10"))
		XCTAssertNotNil(XSD.secondFrag("22"))
		XCTAssertNotNil(XSD.secondFrag("59"))
		XCTAssertNotNil(XSD.secondFrag("00.00"))
		XCTAssertNotNil(XSD.secondFrag("59.95"))
		XCTAssertNil(XSD.secondFrag("00."))
		XCTAssertNil(XSD.secondFrag("010"))
		XCTAssertNil(XSD.secondFrag("1"))
		XCTAssertNil(XSD.secondFrag("60"))
		XCTAssertNil(XSD.secondFrag("72"))
	}

	func testEndOfDayFrag() {
		XCTAssertNotNil(XSD.endOfDayFrag("24:00:00"))
		XCTAssertNotNil(XSD.endOfDayFrag("24:00:00.00"))
		XCTAssertNil(XSD.endOfDayFrag("24:00:00."))
		XCTAssertNil(XSD.endOfDayFrag("24:00:00.01"))
	}

	func testTimezoneFrag() {
		XCTAssertNotNil(XSD.timezoneFrag("Z"))
		XCTAssertNotNil(XSD.timezoneFrag("+00:00"))
		XCTAssertNotNil(XSD.timezoneFrag("-00:00"))
		XCTAssertNotNil(XSD.timezoneFrag("+10:00"))
		XCTAssertNotNil(XSD.timezoneFrag("+13:59"))
		XCTAssertNotNil(XSD.timezoneFrag("+14:00"))
		XCTAssertNotNil(XSD.timezoneFrag("-14:00"))
		XCTAssertNil(XSD.timezoneFrag("z"))
		XCTAssertNil(XSD.timezoneFrag("00:00"))
		XCTAssertNil(XSD.timezoneFrag("14:00"))
		XCTAssertNil(XSD.timezoneFrag("+00"))
		XCTAssertNil(XSD.timezoneFrag("+00:00:00"))
		XCTAssertNil(XSD.timezoneFrag("+12:60"))
		XCTAssertNil(XSD.timezoneFrag("+12:72"))
		XCTAssertNil(XSD.timezoneFrag("+14:01"))
		XCTAssertNil(XSD.timezoneFrag("+15:00"))
		XCTAssertNil(XSD.timezoneFrag("+22:00"))
	}

}
