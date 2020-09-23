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
	static func ·gYearCanonicalMap·(
		_ gY: XSD.GYearValue
	) -> XSD.gYearLexicalRep {
		if let tz = gY.·timezoneOffset· {
			return (
				XSD.·yearCanonicalFragmentMap·(gY.·year·!)
					+ XSD.·timezoneCanonicalFragmentMap·(tz)
			)◊
		} else { return XSD.·yearCanonicalFragmentMap·(gY.·year·!)◊ }
	}

}
