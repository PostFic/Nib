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
	static func ·timeCanonicalMap·(
		_ ti: XSD.TimeValue
	) -> XSD.timeLexicalRep {
		let T = String(
			describing: XSD.·hourCanonicalFragmentMap·(ti.·hour·!)
		) + ":" + String(
			describing: XSD.·minuteCanonicalFragmentMap·(ti.·minute·!)
		) + ":" + String(
			describing: XSD.·secondCanonicalFragmentMap·(ti.·second·!)
		)
		if let tz = ti.·timezoneOffset· {
			return (T + XSD.·timezoneCanonicalFragmentMap·(tz))◊
		} else { return T◊ }
	}

}
