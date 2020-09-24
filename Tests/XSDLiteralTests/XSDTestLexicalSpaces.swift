import XCTest
import XSD
import XSDLiterals

/*
case 16:
return XSD.dateTimeLexicalRep.self
case 17:
return XSD.timeLexicalRep.self
case 18:
return XSD.dateLexicalRep.self
case 19:
return XSD.gYearMonthLexicalRep.self
case 20:
return XSD.gYearLexicalRep.self
case 21:
return XSD.gMonthDayLexicalRep.self
case 22:
return XSD.gDayLexicalRep.self
case 23:
return XSD.gMonthLexicalRep.self
case 24:
return XSD.hexDigit.self
case 25:
return XSD.hexOctet.self
case 26:
return XSD.hexBinaryRep.self
case 27:
return XSD.Base64Binary.self
case 28:
return XSD.B64quad.self
case 29:
return XSD.B64final.self
case 30:
return XSD.B64finalquad.self
case 31:
return XSD.Padded16.self
case 32:
return XSD.Padded8.self
case 33:
return XSD.B64.self
case 34:
return XSD.B64char.self
case 35:
return XSD.B16.self
case 36:
return XSD.B16char.self
case 37:
return XSD.B04.self
case 38:
return XSD.B04char.self
case 39:
return XSD.Canonical·base64Binary.self
case 40:
return XSD.CanonicalQuad.self
case 41:
return XSD.CanonicalPadded.self
case 42:
return XSD.yearMonthDurationLexicalRep.self
case 43:
return XSD.dayTimeLexicalRep.self
case 44:
return XSD.dateTimeStampLexicalRep.self
case 45:
return XSD.digit.self
case 46:
return XSD.unsignedNoDecimalPtNumeral.self
case 47:
return XSD.noDecimalPtNumeral.self
case 48:
return XSD.fracFrag.self
case 49:
return XSD.unsignedDecimalPtNumeral.self
case 50:
return XSD.unsignedFullDecimalPtNumeral.self
case 51:
return XSD.decimalPtNumeral.self
case 52:
return XSD.unsignedScientificNotationNumeral.self
case 53:
return XSD.scientificNotationNumeral.self
case 54:
return XSD.minimalNumericalSpecialRep.self
case 55:
return XSD.numericalSpecialRep.self
case 56:
return XSD.yearFrag.self
case 57:
return XSD.monthFrag.self
case 58:
return XSD.dayFrag.self
case 59:
return XSD.hourFrag.self
case 60:
return XSD.minuteFrag.self
case 61:
return XSD.secondFrag.self
case 62:
return XSD.endOfDayFrag.self
case 63:
return XSD.timezoneFrag.self
*/

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
		XCTAssertNotNil(XSD.durationLexicalRep("-P00Y00M00DT00H00M00.00S"))
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

}
