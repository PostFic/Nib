import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DateValue` to a `XSD.dateLexicalRep`.
	///
	///  +  parameters:
	///      +  da:
	///         A complete `XSD.DateValue`.
	///
	///  +  returns:
	///     A `XSD.dateLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateCanRep>
	@inlinable
	static func ·dateCanonicalMap·(
		_ da: XSD.DateValue
	) -> XSD.dateLexicalRep {
		let D = String(
			describing: XSD.·yearCanonicalFragmentMap·(da.·year·!)
		) + "-" + String(
			describing: XSD.·monthCanonicalFragmentMap·(da.·month·!)
		) + "-" + String(
			describing: XSD.·dayCanonicalFragmentMap·(da.·day·!)
		)
		if let tz = da.·timezoneOffset· {
			return (D + XSD.·timezoneCanonicalFragmentMap·(tz))◊
		} else { return D◊ }
	}

}
