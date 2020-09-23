import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DurationValue`’s property values to
	///   `XSD.durationLexicalRep` fragments and combines the fragments
	///   into a complete `XSD.durationLexicalRep`.
	///
	///  +  parameters:
	///      +  v:
	///         A `XSD.DurationValue`.
	///
	///  +  returns:
	///     A `XSD.durationLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-durationCanMap>
	@inlinable
	static func ·durationCanonicalMap·(
		_ v: XSD.DurationValue
	) -> XSD.durationLexicalRep {
		let m = v.·months·
		let s = v.·seconds·
		let sgn = m < 0 || s < 0 ? "-" : ""
		if m != 0 && s != 0 {
			return (
				sgn + "P"
					+ XSD.·duYearMonthCanonicalFragmentMap·(abs(m))
					+ XSD.·duDayTimeCanonicalFragmentMap·(abs(s))
			)◊
		} else if m != 0 && s == 0 {
			return (
				sgn + "P"
					+ XSD.·duYearMonthCanonicalFragmentMap·(abs(m))
			)◊
		} else {
			return (
				sgn + "P" + XSD.·duDayTimeCanonicalFragmentMap·(abs(s))
			)◊
		}
	}

}
