import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DateTimeValue` to a `XSD.dateTimeLexicalRep`.
	///
	///  +  parameters:
	///      +  dt:
	///         A complete `XSD.DateTimeValue`.
	///
	///  +  returns:
	///     A `XSD.dateTimeLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dateTimeCanRep>
	@inlinable
	static func ·dateTimeCanonicalMap· (
		_ dt: XSD.DateTimeValue
	) -> XSD.dateTimeLexicalRep {
		let DT = String(XSD.·yearCanonicalFragmentMap·(dt.·year·.unsafelyUnwrapped)) + "-" + String(XSD.·monthCanonicalFragmentMap·(dt.·month·.unsafelyUnwrapped)) + "-" + String(XSD.·dayCanonicalFragmentMap·(dt.·day·.unsafelyUnwrapped)) + "T" + String(XSD.·hourCanonicalFragmentMap·(dt.·hour·.unsafelyUnwrapped)) + ":" + String(XSD.·minuteCanonicalFragmentMap·(dt.·minute·.unsafelyUnwrapped)) + ":" + String(XSD.·secondCanonicalFragmentMap·(dt.·second·.unsafelyUnwrapped))
		if let tz = dt.·timezoneOffset·
		{ return XSD.dateTimeLexicalRep(DT + String(XSD.·timezoneCanonicalFragmentMap·(tz)))! }
		else
		{ return XSD.dateTimeLexicalRep(DT)! }
	}

}
