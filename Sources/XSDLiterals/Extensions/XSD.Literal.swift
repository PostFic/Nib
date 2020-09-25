import XSD

public extension XSD.Literal {

	/// The `XSD.Literal` subclasses with the lexical spaces
	///   defined by XSD, by number.
	///
	///  +  parameters:
	///      +  index:
	///         The index (1–63) of the lexical space in XSD.
	///
	///  +  returns:
	///     A `XSD.Literal` subclass, or the `XSD.Literal` class
	///       itself if no lexical space for the given index is
	///       provided.
	static subscript (
		index: UInt
	) -> XSD.Literal.Type {
		switch index {
		case 1:
			return XSD.stringRep.self
		case 2:
			return XSD.booleanRep.self
		case 3:
			return XSD.decimalLexicalRep.self
		case 4:
			return XSD.floatRep.self
		case 5:
			return XSD.doubleRep.self
		case 6:
			return XSD.duYearFrag.self
		case 7:
			return XSD.duMonthFrag.self
		case 8:
			return XSD.duDayFrag.self
		case 9:
			return XSD.duHourFrag.self
		case 10:
			return XSD.duMinuteFrag.self
		case 11:
			return XSD.duSecondFrag.self
		case 12:
			return XSD.duYearMonthFrag.self
		case 13:
			return XSD.duTimeFrag.self
		case 14:
			return XSD.duDayTimeFrag.self
		case 15:
			return XSD.durationLexicalRep.self
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
			return XSD.dayTimeDurationLexicalRep.self
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
		default:
			return XSD.Literal.self
		}
	}
	
}
