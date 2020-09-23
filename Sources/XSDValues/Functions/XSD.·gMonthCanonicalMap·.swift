import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.GMonthValue` to a `XSD.gMonthLexicalRep`.
	///
	///  +  parameters:
	///      +  gD:
	///         A complete `XSD.GMonthValue`.
	///
	///  +  returns:
	///     A `XSD.gMonthLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthCanRep>
	@inlinable
	static func ·gMonthCanonicalMap·(
		_ gM: XSD.GMonthValue
	) -> XSD.gMonthLexicalRep {
		if let tz = gM.·timezoneOffset· {
			return (
				XSD.·monthCanonicalFragmentMap·(gM.·month·!)
					+ XSD.·timezoneCanonicalFragmentMap·(tz)
			)◊
		} else { return XSD.·monthCanonicalFragmentMap·(gM.·month·!)◊ }
	}

}
