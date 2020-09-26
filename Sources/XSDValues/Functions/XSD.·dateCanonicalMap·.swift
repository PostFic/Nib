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
	static func ·dateCanonicalMap· (
		_ da: XSD.DateValue
	) -> XSD.dateLexicalRep {
		let D = String(XSD.·yearCanonicalFragmentMap·(da.·year·.unsafelyUnwrapped)) + "-" + String(XSD.·monthCanonicalFragmentMap·(da.·month·.unsafelyUnwrapped)) + "-" + String(XSD.·dayCanonicalFragmentMap·(da.·day·.unsafelyUnwrapped))
		if let tz = da.·timezoneOffset·
		{ return XSD.dateLexicalRep(D + String(XSD.·timezoneCanonicalFragmentMap·(tz)))! }
		else
		{ return XSD.dateLexicalRep(D)! }
	}

}
