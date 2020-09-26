import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.GYearMonthValue` to a `XSD.gYearMonthLexicalRep`.
	///
	///  +  parameters:
	///      +  ym:
	///         A complete `XSD.GYearMonthValue`.
	///
	///  +  returns:
	///     A `XSD.gYearMonthLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearMonthCanRep>
	@inlinable
	static func ·gYearMonthCanonicalMap· (
		_ ym: XSD.GYearMonthValue
	) -> XSD.gYearMonthLexicalRep {
		let YM = String(XSD.·yearCanonicalFragmentMap·(ym.·year·.unsafelyUnwrapped)) + "-" + String(XSD.·monthCanonicalFragmentMap·(ym.·month·.unsafelyUnwrapped))
		if let tz = ym.·timezoneOffset·
		{ return XSD.gYearMonthLexicalRep(YM + String(XSD.·timezoneCanonicalFragmentMap·(tz)))! }
		else
		{ return XSD.gYearMonthLexicalRep(YM)! }
	}

}
