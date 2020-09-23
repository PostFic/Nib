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
	static func ·dateTimeCanonicalMap·(
		_ dt: XSD.DateTimeValue
	) -> XSD.dateTimeLexicalRep {
		let DT = String(
			describing: XSD.·yearCanonicalFragmentMap·(dt.·year·!)
		) + "-" + String(
			describing: XSD.·monthCanonicalFragmentMap·(dt.·month·!)
		) + "-" + String(
			describing: XSD.·dayCanonicalFragmentMap·(dt.·day·!)
		) + "T" + String(
			describing: XSD.·hourCanonicalFragmentMap·(dt.·hour·!)
		) + ":" + String(
			describing: XSD.·minuteCanonicalFragmentMap·(dt.·minute·!)
		) + ":" + String(
			describing: XSD.·secondCanonicalFragmentMap·(dt.·second·!)
		)
		if let tz = dt.·timezoneOffset· {
			return (DT + XSD.·timezoneCanonicalFragmentMap·(tz))◊
		} else { return DT◊ }
	}

}
