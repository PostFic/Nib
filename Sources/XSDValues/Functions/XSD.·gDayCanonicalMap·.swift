import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.GDayValue` to a `XSD.gDayLexicalRep`.
	///
	///  +  parameters:
	///      +  gD:
	///         A complete `XSD.GDayValue`.
	///
	///  +  returns:
	///     A `XSD.gDayLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gDayCanRep>
	@inlinable
	static func ·gDayCanonicalMap· (
		_ gD: XSD.GDayValue
	) -> XSD.gDayLexicalRep {
		if let tz = gD.·timezoneOffset·
		{ return XSD.gDayLexicalRep("---" + String(XSD.·dayCanonicalFragmentMap·(gD.·day·.unsafelyUnwrapped)) + String(XSD.·timezoneCanonicalFragmentMap·(tz)))! }
		else
		{ return XSD.gDayLexicalRep("---" + String(XSD.·dayCanonicalFragmentMap·(gD.·day·.unsafelyUnwrapped)))! }
	}

}
