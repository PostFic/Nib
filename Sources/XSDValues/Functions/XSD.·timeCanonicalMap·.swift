import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.TimeValue` to a `XSD.timeLexicalRep`.
	///
	///  +  parameters:
	///      +  ti:
	///         A complete `XSD.TimeValue`.
	///
	///  +  returns:
	///     A `XSD.timeLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-timeCanRep>
	@inlinable
	static func ·timeCanonicalMap· (
		_ ti: XSD.TimeValue
	) -> XSD.timeLexicalRep {
		let T = String(XSD.·hourCanonicalFragmentMap·(ti.·hour·.unsafelyUnwrapped)) + ":" + String(XSD.·minuteCanonicalFragmentMap·(ti.·minute·.unsafelyUnwrapped)) + ":" + String(XSD.·secondCanonicalFragmentMap·(ti.·second·.unsafelyUnwrapped))
		if let tz = ti.·timezoneOffset·
		{ return XSD.timeLexicalRep(T + String(XSD.·timezoneCanonicalFragmentMap·(tz)))! }
		else { return XSD.timeLexicalRep(T)! }
	}

}
