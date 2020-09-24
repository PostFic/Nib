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
		XCTAssertNotNil(XSD.floatRep("00"))
		XCTAssertNotNil(XSD.floatRep("+00"))
		XCTAssertNotNil(XSD.floatRep("-00"))
		XCTAssertNotNil(XSD.floatRep("00."))
		XCTAssertNotNil(XSD.floatRep("00.00"))
		XCTAssertNotNil(XSD.floatRep(".00"))
		XCTAssertNotNil(XSD.floatRep("+00.00"))
		XCTAssertNotNil(XSD.floatRep("-00.00"))
		XCTAssertNotNil(XSD.floatRep("00e00"))
		XCTAssertNotNil(XSD.floatRep(".00E00"))
		XCTAssertNotNil(XSD.floatRep("00.00e00"))
		XCTAssertNotNil(XSD.floatRep("+00.00e00"))
		XCTAssertNotNil(XSD.floatRep("-00.00e00"))
		XCTAssertNotNil(XSD.floatRep("INF"))
		XCTAssertNotNil(XSD.floatRep("+INF"))
		XCTAssertNotNil(XSD.floatRep("-INF"))
		XCTAssertNotNil(XSD.floatRep("NaN"))
		XCTAssertNil(XSD.floatRep("."))
		XCTAssertNil(XSD.floatRep("+"))
		XCTAssertNil(XSD.floatRep("-"))
		XCTAssertNil(XSD.floatRep("E"))
		XCTAssertNil(XSD.floatRep("e"))
		XCTAssertNil(XSD.floatRep("00.00e00.00"))
		XCTAssertNil(XSD.floatRep("inf"))
		XCTAssertNil(XSD.floatRep("NAN"))
		XCTAssertNil(XSD.floatRep("+NaN"))
		XCTAssertNil(XSD.floatRep("-NaN"))
	}

	func testDoubleRep() {
		XCTAssertNotNil(XSD.doubleRep("00"))
		XCTAssertNotNil(XSD.doubleRep("+00"))
		XCTAssertNotNil(XSD.doubleRep("-00"))
		XCTAssertNotNil(XSD.doubleRep("00."))
		XCTAssertNotNil(XSD.doubleRep("00.00"))
		XCTAssertNotNil(XSD.doubleRep(".00"))
		XCTAssertNotNil(XSD.doubleRep("+00.00"))
		XCTAssertNotNil(XSD.doubleRep("-00.00"))
		XCTAssertNotNil(XSD.doubleRep("00e00"))
		XCTAssertNotNil(XSD.doubleRep(".00E00"))
		XCTAssertNotNil(XSD.doubleRep("00.00e00"))
		XCTAssertNotNil(XSD.doubleRep("+00.00e00"))
		XCTAssertNotNil(XSD.doubleRep("-00.00e00"))
		XCTAssertNotNil(XSD.doubleRep("INF"))
		XCTAssertNotNil(XSD.doubleRep("+INF"))
		XCTAssertNotNil(XSD.doubleRep("-INF"))
		XCTAssertNotNil(XSD.doubleRep("NaN"))
		XCTAssertNil(XSD.doubleRep("."))
		XCTAssertNil(XSD.doubleRep("+"))
		XCTAssertNil(XSD.doubleRep("-"))
		XCTAssertNil(XSD.doubleRep("E"))
		XCTAssertNil(XSD.doubleRep("e"))
		XCTAssertNil(XSD.doubleRep("00.00e00.00"))
		XCTAssertNil(XSD.doubleRep("inf"))
		XCTAssertNil(XSD.doubleRep("NAN"))
		XCTAssertNil(XSD.doubleRep("+NaN"))
		XCTAssertNil(XSD.doubleRep("-NaN"))
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

	func testHexDigit() {
		XCTAssertNotNil(XSD.hexDigit("0"))
		XCTAssertNotNil(XSD.hexDigit("e"))
		XCTAssertNotNil(XSD.hexDigit("F"))
		XCTAssertNil(XSD.hexDigit("G"))
	}

	func testHexOctet() {
		XCTAssertNotNil(XSD.hexOctet("00"))
		XCTAssertNotNil(XSD.hexOctet("ee"))
		XCTAssertNotNil(XSD.hexOctet("FF"))
		XCTAssertNil(XSD.hexOctet("G0"))
	}

	func testHexBinaryRep() {
		XCTAssertNotNil(XSD.hexBinaryRep("0FB7"))
		XCTAssertNotNil(XSD.hexBinaryRep("800bea"))
		XCTAssertNil(XSD.hexBinaryRep("F"))
		XCTAssertNil(XSD.hexBinaryRep("0F B7"))
		XCTAssertNil(XSD.hexBinaryRep("LEAF"))
	}

	func test·Base64Binary() {
		XCTAssertNotNil(XSD.Base64Binary("KiBi1024"))
		XCTAssertNotNil(XSD.Base64Binary("KiBiBAo="))
		XCTAssertNotNil(XSD.Base64Binary("KiBiBA=="))
		XCTAssertNotNil(XSD.Base64Binary("K iBi"))
		XCTAssertNotNil(XSD.Base64Binary("Ki Bi"))
		XCTAssertNotNil(XSD.Base64Binary("KiB i"))
		XCTAssertNil(XSD.Base64Binary(" KiBi1024"))
		XCTAssertNil(XSD.Base64Binary("KiBi1024 "))
		XCTAssertNil(XSD.Base64Binary("BAo=1024"))
		XCTAssertNil(XSD.Base64Binary("BA==1024"))
	}

	func test·B64quad() {
		XCTAssertNotNil(XSD.B64quad("KiBi"))
		XCTAssertNotNil(XSD.B64quad("K iBi"))
		XCTAssertNotNil(XSD.B64quad("Ki Bi"))
		XCTAssertNotNil(XSD.B64quad("KiB i"))
		XCTAssertNotNil(XSD.B64quad("KiB i "))
		XCTAssertNotNil(XSD.B64quad("K i B i "))
		XCTAssertNil(XSD.B64quad(" KiBi"))
	}

	func test·B64final() {
		XCTAssertNotNil(XSD.B64final("KiBi"))
		XCTAssertNotNil(XSD.B64final("BAo="))
		XCTAssertNotNil(XSD.B64final("BA=="))
		XCTAssertNotNil(XSD.B64final("K iBi"))
		XCTAssertNotNil(XSD.B64final("Ki Bi"))
		XCTAssertNotNil(XSD.B64final("KiB i"))
		XCTAssertNotNil(XSD.B64final("K i B i"))
		XCTAssertNil(XSD.B64final("===="))
		XCTAssertNil(XSD.B64final("A==="))
		XCTAssertNil(XSD.B64final(" KiBi"))
		XCTAssertNil(XSD.B64final("KiBi "))
	}

	func test·B64finalquad() {
		XCTAssertNotNil(XSD.B64finalquad("KiBi"))
		XCTAssertNotNil(XSD.B64finalquad("K iBi"))
		XCTAssertNotNil(XSD.B64finalquad("Ki Bi"))
		XCTAssertNotNil(XSD.B64finalquad("KiB i"))
		XCTAssertNotNil(XSD.B64finalquad("K i B i"))
		XCTAssertNil(XSD.B64finalquad(" KiBi"))
		XCTAssertNil(XSD.B64finalquad("KiBi "))
	}

	func test·Padded16() {
		XCTAssertNotNil(XSD.Padded16("BAo="))
		XCTAssertNotNil(XSD.Padded16("B Ao="))
		XCTAssertNotNil(XSD.Padded16("BA o="))
		XCTAssertNotNil(XSD.Padded16("BAo ="))
		XCTAssertNotNil(XSD.Padded16("B A o ="))
		XCTAssertNil(XSD.Padded16(" BAo="))
		XCTAssertNil(XSD.Padded16("BAo=="))
		XCTAssertNil(XSD.Padded16("BAo= "))
		XCTAssertNil(XSD.Padded16("BAo"))
		XCTAssertNil(XSD.Padded16("BAD="))
	}

	func test·Padded8() {
		XCTAssertNotNil(XSD.Padded8("BA=="))
		XCTAssertNotNil(XSD.Padded8("B A=="))
		XCTAssertNotNil(XSD.Padded8("BA =="))
		XCTAssertNotNil(XSD.Padded8("BA= ="))
		XCTAssertNotNil(XSD.Padded8("B A = ="))
		XCTAssertNil(XSD.Padded8(" BA=="))
		XCTAssertNil(XSD.Padded8("BA==="))
		XCTAssertNil(XSD.Padded8("BA== "))
		XCTAssertNil(XSD.Padded8("BA="))
		XCTAssertNil(XSD.Padded8("BG=="))
	}

	func test·B64() {
		XCTAssertNotNil(XSD.B64("B"))
		XCTAssertNotNil(XSD.B64("0 "))
		XCTAssertNotNil(XSD.B64("+"))
		XCTAssertNotNil(XSD.B64("/ "))
		XCTAssertNil(XSD.B64(" B"))
		XCTAssertNil(XSD.B64("B  "))
		XCTAssertNil(XSD.B64("-"))
		XCTAssertNil(XSD.B64(#"\"#))
	}

	func test·B64char() {
		XCTAssertNotNil(XSD.B64char("B"))
		XCTAssertNotNil(XSD.B64char("0"))
		XCTAssertNotNil(XSD.B64char("+"))
		XCTAssertNotNil(XSD.B64char("/"))
		XCTAssertNil(XSD.B64char("B "))
		XCTAssertNil(XSD.B64char("-"))
		XCTAssertNil(XSD.B64char(#"\"#))
	}

	func test·B16() {
		XCTAssertNotNil(XSD.B16("E"))
		XCTAssertNotNil(XSD.B16("Y "))
		XCTAssertNotNil(XSD.B16("k"))
		XCTAssertNotNil(XSD.B16("o "))
		XCTAssertNil(XSD.B16(" E"))
		XCTAssertNil(XSD.B16("E  "))
		XCTAssertNil(XSD.B16("e"))
		XCTAssertNil(XSD.B16("B"))
	}

	func test·B16char() {
		XCTAssertNotNil(XSD.B16char("E"))
		XCTAssertNotNil(XSD.B16char("Y"))
		XCTAssertNotNil(XSD.B16char("k"))
		XCTAssertNotNil(XSD.B16char("o"))
		XCTAssertNil(XSD.B16char("E "))
		XCTAssertNil(XSD.B16char("e"))
		XCTAssertNil(XSD.B16char("B"))
	}

	func test·B04() {
		XCTAssertNotNil(XSD.B04("A"))
		XCTAssertNotNil(XSD.B04("Q "))
		XCTAssertNotNil(XSD.B04("g"))
		XCTAssertNotNil(XSD.B04("w "))
		XCTAssertNil(XSD.B04(" A"))
		XCTAssertNil(XSD.B04("A  "))
		XCTAssertNil(XSD.B04("a"))
		XCTAssertNil(XSD.B04("E"))
	}

	func test·B04char() {
		XCTAssertNotNil(XSD.B04char("A"))
		XCTAssertNotNil(XSD.B04char("Q"))
		XCTAssertNotNil(XSD.B04char("g"))
		XCTAssertNotNil(XSD.B04char("w"))
		XCTAssertNil(XSD.B04char("A "))
		XCTAssertNil(XSD.B04char("a"))
		XCTAssertNil(XSD.B04char("E"))
	}

	func test·Canonical·base64Binary() {
		XCTAssertNotNil(XSD.Canonical·base64Binary("KiBi1024"))
		XCTAssertNotNil(XSD.Canonical·base64Binary("KiBiBAo="))
		XCTAssertNotNil(XSD.Canonical·base64Binary("KiBiBA=="))
		XCTAssertNil(XSD.Canonical·base64Binary("K iBi"))
		XCTAssertNil(XSD.Canonical·base64Binary("Ki Bi"))
		XCTAssertNil(XSD.Canonical·base64Binary("KiB i"))
		XCTAssertNil(XSD.Canonical·base64Binary(" KiBi1024"))
		XCTAssertNil(XSD.Canonical·base64Binary("KiBi1024 "))
		XCTAssertNil(XSD.Canonical·base64Binary("BAo=1024"))
		XCTAssertNil(XSD.Canonical·base64Binary("BA==1024"))
	}

	func test·CanonicalQuad() {
		XCTAssertNotNil(XSD.CanonicalQuad("KiBi"))
		XCTAssertNil(XSD.CanonicalQuad("K iBi"))
		XCTAssertNil(XSD.CanonicalQuad("Ki Bi"))
		XCTAssertNil(XSD.CanonicalQuad("KiB i"))
		XCTAssertNil(XSD.CanonicalQuad("KiB i "))
		XCTAssertNil(XSD.CanonicalQuad("K i B i "))
		XCTAssertNil(XSD.CanonicalQuad(" KiBi"))
	}

	func test·CanonicalPadded() {
		XCTAssertNotNil(XSD.CanonicalPadded("BAo="))
		XCTAssertNotNil(XSD.CanonicalPadded("BA=="))
		XCTAssertNil(XSD.CanonicalPadded("B Ao="))
		XCTAssertNil(XSD.CanonicalPadded("BA o="))
		XCTAssertNil(XSD.CanonicalPadded("BAo ="))
		XCTAssertNil(XSD.CanonicalPadded("B A o ="))
		XCTAssertNil(XSD.CanonicalPadded(" BAo="))
		XCTAssertNil(XSD.CanonicalPadded("BAo=="))
		XCTAssertNil(XSD.CanonicalPadded("BAo= "))
		XCTAssertNil(XSD.CanonicalPadded("BAo"))
		XCTAssertNil(XSD.CanonicalPadded("BAD="))
		XCTAssertNil(XSD.CanonicalPadded("B A=="))
		XCTAssertNil(XSD.CanonicalPadded("BA =="))
		XCTAssertNil(XSD.CanonicalPadded("BA= ="))
		XCTAssertNil(XSD.CanonicalPadded("B A = ="))
		XCTAssertNil(XSD.CanonicalPadded(" BA=="))
		XCTAssertNil(XSD.CanonicalPadded("BA==="))
		XCTAssertNil(XSD.CanonicalPadded("BA== "))
		XCTAssertNil(XSD.CanonicalPadded("BA="))
		XCTAssertNil(XSD.CanonicalPadded("BG=="))
	}

	func testYearMonthDurationLexicalRep() {
		XCTAssertNotNil(XSD.yearMonthDurationLexicalRep("-P00Y00M"))
		XCTAssertNotNil(XSD.yearMonthDurationLexicalRep("P0M"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("PT.0S"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("-P0D"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("-"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("P"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("0"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("PY"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("PTS"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("+P0S"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("P0MT"))
		XCTAssertNil(XSD.yearMonthDurationLexicalRep("PT0S0M"))
	}

	func testDayTimeDurationLexicalRep() {
		XCTAssertNotNil(
			XSD.dayTimeDurationLexicalRep("-P00DT00H00M00.00S")
		)
		XCTAssertNotNil(XSD.dayTimeDurationLexicalRep("PT.0S"))
		XCTAssertNotNil(XSD.dayTimeDurationLexicalRep("-P0D"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("P0M"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("-"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("P"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("0"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("PY"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("PTS"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("+P0S"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("P0MT"))
		XCTAssertNil(XSD.dayTimeDurationLexicalRep("PT0S0M"))
	}

	func testDateTimeStampLexicalRep() {
		XCTAssertNotNil(
			XSD.dateTimeStampLexicalRep("1972-12-31T00:00:00Z")
		)
		XCTAssertNotNil(
			XSD.dateTimeStampLexicalRep("0000-01-01T24:00:00Z")
		)
		XCTAssertNotNil(
			XSD.dateTimeStampLexicalRep("-0000-01-01T23:59:59Z")
		)
		XCTAssertNotNil(
			XSD.dateTimeStampLexicalRep("19720-02-29T00:00:00Z")
		)
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
		XCTAssertNil(
			XSD.dateTimeStampLexicalRep("1972-12-31T00:00:00")
		)
		XCTAssertNil(
			XSD.dateTimeStampLexicalRep("-0000-01-01T23:59:59")
		)
		XCTAssertNil(
			XSD.dateTimeStampLexicalRep("19720-02-29T00:00:00")
		)
		XCTAssertNil(XSD.dateTimeLexicalRep("+1972-12-31T00:00:00Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("01972-12-31T00:00:00Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31T00:00:00.Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("0000-00-00T00:00:00Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("9999-99-99T99:99:99Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("0000-04-31T00:00:00Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("0000-02-30T00:00:00Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("0001-02-29T00:00:00Z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31T00:00:00z"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31T00:00:00+14"))
		XCTAssertNil(XSD.dateTimeLexicalRep("1972-12-31Z"))
	}

	func testDigit() {
		XCTAssertNotNil(XSD.digit("0"))
		XCTAssertNotNil(XSD.digit("1"))
		XCTAssertNotNil(XSD.digit("2"))
		XCTAssertNotNil(XSD.digit("3"))
		XCTAssertNotNil(XSD.digit("4"))
		XCTAssertNotNil(XSD.digit("5"))
		XCTAssertNotNil(XSD.digit("6"))
		XCTAssertNotNil(XSD.digit("7"))
		XCTAssertNotNil(XSD.digit("8"))
		XCTAssertNotNil(XSD.digit("9"))
		XCTAssertNil(XSD.digit("↊"))
		XCTAssertNil(XSD.digit("↋"))
		XCTAssertNil(XSD.digit(""))
	}

	func testUnsignedNoDecimalPtNumeral() {
		XCTAssertNotNil(XSD.unsignedNoDecimalPtNumeral("00"))
		XCTAssertNotNil(XSD.unsignedNoDecimalPtNumeral("0123456789"))
		XCTAssertNil(XSD.unsignedNoDecimalPtNumeral("+0"))
		XCTAssertNil(XSD.unsignedNoDecimalPtNumeral("-0"))
		XCTAssertNil(XSD.unsignedNoDecimalPtNumeral("0.0"))
		XCTAssertNil(XSD.unsignedNoDecimalPtNumeral(""))
	}

	func testNoDecimalPtNumeral() {
		XCTAssertNotNil(XSD.noDecimalPtNumeral("00"))
		XCTAssertNotNil(XSD.noDecimalPtNumeral("0123456789"))
		XCTAssertNotNil(XSD.noDecimalPtNumeral("+0"))
		XCTAssertNotNil(XSD.noDecimalPtNumeral("-0"))
		XCTAssertNil(XSD.noDecimalPtNumeral("0.0"))
		XCTAssertNil(XSD.noDecimalPtNumeral("+0.0"))
		XCTAssertNil(XSD.noDecimalPtNumeral("-0.0"))
		XCTAssertNil(XSD.noDecimalPtNumeral(""))
		XCTAssertNil(XSD.decimalPtNumeral("+"))
		XCTAssertNil(XSD.decimalPtNumeral("-"))
	}

	func testFracFrag() {
		XCTAssertNotNil(XSD.fracFrag("00"))
		XCTAssertNotNil(XSD.fracFrag("0123456789"))
		XCTAssertNil(XSD.fracFrag("+0"))
		XCTAssertNil(XSD.fracFrag("-0"))
		XCTAssertNil(XSD.fracFrag("0.0"))
		XCTAssertNil(XSD.fracFrag(""))
	}

	func testUnsignedDecimalPtNumeral() {
		XCTAssertNotNil(XSD.unsignedDecimalPtNumeral("00."))
		XCTAssertNotNil(XSD.unsignedDecimalPtNumeral("00.00"))
		XCTAssertNotNil(XSD.unsignedDecimalPtNumeral(".00"))
		XCTAssertNotNil(
			XSD.unsignedDecimalPtNumeral("0123456789.0123456789")
		)
		XCTAssertNil(XSD.unsignedDecimalPtNumeral("0"))
		XCTAssertNil(XSD.unsignedDecimalPtNumeral("+0."))
		XCTAssertNil(XSD.unsignedDecimalPtNumeral("-0."))
		XCTAssertNil(XSD.unsignedDecimalPtNumeral(""))
		XCTAssertNil(XSD.unsignedDecimalPtNumeral("."))
	}

	func testUnsignedFullDecimalPtNumeral() {
		XCTAssertNotNil(XSD.unsignedFullDecimalPtNumeral("00.00"))
		XCTAssertNotNil(
			XSD.unsignedFullDecimalPtNumeral("0123456789.0123456789")
		)
		XCTAssertNil(XSD.unsignedFullDecimalPtNumeral("00"))
		XCTAssertNil(XSD.unsignedFullDecimalPtNumeral("00."))
		XCTAssertNil(XSD.unsignedFullDecimalPtNumeral(".00"))
		XCTAssertNil(XSD.unsignedFullDecimalPtNumeral("+00.00"))
		XCTAssertNil(XSD.unsignedFullDecimalPtNumeral("-00.00"))
		XCTAssertNil(XSD.unsignedFullDecimalPtNumeral("."))
	}

	func testDecimalPtNumeral() {
		XCTAssertNotNil(XSD.decimalPtNumeral("00."))
		XCTAssertNotNil(XSD.decimalPtNumeral("+00."))
		XCTAssertNotNil(XSD.decimalPtNumeral("-00."))
		XCTAssertNotNil(XSD.decimalPtNumeral("00.00"))
		XCTAssertNotNil(XSD.decimalPtNumeral("+00.00"))
		XCTAssertNotNil(XSD.decimalPtNumeral("-00.00"))
		XCTAssertNotNil(XSD.decimalPtNumeral(".00"))
		XCTAssertNotNil(XSD.decimalPtNumeral("+.00"))
		XCTAssertNotNil(XSD.decimalPtNumeral("-.00"))
		XCTAssertNotNil(XSD.decimalPtNumeral("0123456789.0123456789"))
		XCTAssertNotNil(XSD.decimalPtNumeral("+0123456789.0123456789"))
		XCTAssertNotNil(XSD.decimalPtNumeral("-0123456789.0123456789"))
		XCTAssertNil(XSD.decimalPtNumeral("00"))
		XCTAssertNil(XSD.decimalPtNumeral("+00"))
		XCTAssertNil(XSD.decimalPtNumeral("-00"))
		XCTAssertNil(XSD.decimalPtNumeral(""))
		XCTAssertNil(XSD.decimalPtNumeral("."))
		XCTAssertNil(XSD.decimalPtNumeral("+"))
		XCTAssertNil(XSD.decimalPtNumeral("-"))
	}

	func testUnsignedScientificNotationNumeral() {
		XCTAssertNotNil(XSD.unsignedScientificNotationNumeral("00e00"))
		XCTAssertNotNil(
			XSD.unsignedScientificNotationNumeral(".00E00")
		)
		XCTAssertNotNil(
			XSD.unsignedScientificNotationNumeral("00.00e00")
		)
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("00."))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("00.00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral(".00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("+00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("-00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("+00.00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("-00.00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("+00.00e00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("-00.00e00"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("."))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("E"))
		XCTAssertNil(XSD.unsignedScientificNotationNumeral("e"))
		XCTAssertNil(
			XSD.unsignedScientificNotationNumeral("00.00e00.00")
		)
	}

	func testScientificNotationNumeral() {
		XCTAssertNotNil(XSD.scientificNotationNumeral("00e00"))
		XCTAssertNotNil(XSD.scientificNotationNumeral(".00E00"))
		XCTAssertNotNil(XSD.scientificNotationNumeral("00.00e00"))
		XCTAssertNotNil(XSD.scientificNotationNumeral("+00.00e00"))
		XCTAssertNotNil(XSD.scientificNotationNumeral("-00.00e00"))
		XCTAssertNil(XSD.scientificNotationNumeral("00"))
		XCTAssertNil(XSD.scientificNotationNumeral("+00"))
		XCTAssertNil(XSD.scientificNotationNumeral("-00"))
		XCTAssertNil(XSD.scientificNotationNumeral("00."))
		XCTAssertNil(XSD.scientificNotationNumeral("00.00"))
		XCTAssertNil(XSD.scientificNotationNumeral(".00"))
		XCTAssertNil(XSD.scientificNotationNumeral("+00.00"))
		XCTAssertNil(XSD.scientificNotationNumeral("-00.00"))
		XCTAssertNil(XSD.scientificNotationNumeral("."))
		XCTAssertNil(XSD.scientificNotationNumeral("+"))
		XCTAssertNil(XSD.scientificNotationNumeral("-"))
		XCTAssertNil(XSD.scientificNotationNumeral("E"))
		XCTAssertNil(XSD.scientificNotationNumeral("e"))
		XCTAssertNil(XSD.scientificNotationNumeral("00.00e00.00"))
	}

	func testMinimalNumericalSpecialRep() {
		XCTAssertNotNil(XSD.minimalNumericalSpecialRep("INF"))
		XCTAssertNotNil(XSD.minimalNumericalSpecialRep("-INF"))
		XCTAssertNotNil(XSD.minimalNumericalSpecialRep("NaN"))
		XCTAssertNil(XSD.minimalNumericalSpecialRep("+INF"))
		XCTAssertNil(XSD.minimalNumericalSpecialRep("inf"))
		XCTAssertNil(XSD.minimalNumericalSpecialRep("-inf"))
		XCTAssertNil(XSD.minimalNumericalSpecialRep("NAN"))
		XCTAssertNil(XSD.minimalNumericalSpecialRep("nan"))
		XCTAssertNil(XSD.minimalNumericalSpecialRep("+NaN"))
		XCTAssertNil(XSD.minimalNumericalSpecialRep("-NaN"))
	}

	func testNumericalSpecialRep() {
		XCTAssertNotNil(XSD.numericalSpecialRep("INF"))
		XCTAssertNotNil(XSD.numericalSpecialRep("-INF"))
		XCTAssertNotNil(XSD.numericalSpecialRep("NaN"))
		XCTAssertNotNil(XSD.numericalSpecialRep("+INF"))
		XCTAssertNil(XSD.numericalSpecialRep("inf"))
		XCTAssertNil(XSD.numericalSpecialRep("-inf"))
		XCTAssertNil(XSD.numericalSpecialRep("+inf"))
		XCTAssertNil(XSD.numericalSpecialRep("NAN"))
		XCTAssertNil(XSD.numericalSpecialRep("nan"))
		XCTAssertNil(XSD.numericalSpecialRep("+NaN"))
		XCTAssertNil(XSD.numericalSpecialRep("-NaN"))
	}

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
