import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalNumber`, presumably the absolute value of
	///   the `·seconds·` of a `XSD.DurationValue`, to a
	///   `XSD.duDayTimeFrag`, a fragment of a `XSD.DurationValue`
	///   lexical representation.
	///
	///  +  parameters:
	///      +  ss:
	///         A nonnegative `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.duDayTimeFrag`
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDTCan>
	@inlinable
	static func ·duDayTimeCanonicalFragmentMap·(
		_ ss: XSD.DecimalNumber
	) -> XSD.duDayTimeFrag {
		let d = XSD.·div·(ss, 86400)
		let h = XSD.·div·(XSD.·mod·(ss, 86400), 3600)
		let m = XSD.·div·(XSD.·mod·(ss, 3600), 60)
		let s = XSD.·mod·(ss, 60)
		if ss != 0 {
			return (
				XSD.·duDayCanonicalFragmentMap·(d)
					+ XSD.·duTimeCanonicalFragmentMap·(h, m, s)
			)◊
		} else { return "T0S"◊ }
	}

}
