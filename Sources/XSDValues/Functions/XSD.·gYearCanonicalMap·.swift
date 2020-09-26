import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.GYearValue` to a `XSD.gYearLexicalRep`.
	///
	///  +  parameters:
	///      +  gY:
	///         A complete `XSD.GYearValue`.
	///
	///  +  returns:
	///     A `XSD.gYearLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gYearCanRep>
	@inlinable
	static func ·gYearCanonicalMap· (
		_ gY: XSD.GYearValue
	) -> XSD.gYearLexicalRep {
		if let tz = gY.·timezoneOffset·
		{ return XSD.gYearLexicalRep(String(XSD.·yearCanonicalFragmentMap·(gY.·year·.unsafelyUnwrapped)) + String(XSD.·timezoneCanonicalFragmentMap·(tz)))! }
		else
		{ return XSD.gYearLexicalRep(XSD.·yearCanonicalFragmentMap·(gY.·year·.unsafelyUnwrapped))! }
	}

}
