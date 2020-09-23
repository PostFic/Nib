import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.GMonthDayValue` to a `XSD.gMonthDayLexicalRep`.
	///
	///  +  parameters:
	///      +  da:
	///         A complete `XSD.GMonthDayValue`.
	///
	///  +  returns:
	///     A `XSD.gMonthDayLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-gMonthDayCanRep>
	@inlinable
	static func ·gMonthDayCanonicalMap·(
		_ md: XSD.GMonthDayValue
	) -> XSD.gMonthDayLexicalRep {
		let MD = String(
			describing: XSD.·monthCanonicalFragmentMap·(md.·month·!)
		) + "-" + String(
			describing: XSD.·dayCanonicalFragmentMap·(md.·day·!)
		)
		if let tz = md.·timezoneOffset· {
			return (MD + XSD.·timezoneCanonicalFragmentMap·(tz))◊
		} else { return MD◊ }
	}

}
