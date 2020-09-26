import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DurationValue`’s `·seconds·` value to a
	///   `XSD.dayTimeDurationLexicalRep`.
	///
	///  +  parameters:
	///      +  dt:
	///         A `XSD.DurationValue` with a zero `·months·` value.
	///
	///  +  returns:
	///     A `XSD.dayTimeDurationLexicalRep`.
	///
	/// `XSD.·dayTimeDurationCanonicalMap·` is a restriction of
	///   `XSD.·durationCanonicalMap·`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dayTimeDurationCanMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly calls
	///       `XSD.·duYearMonthCanonicalFragmentMap·` instead of
	///       `XSD.·duDayTimeCanonicalFragmentMap·` in its provided
	///       algorithm.
	///     Nib gives the correct implementation.
	@inlinable
	static func ·dayTimeDurationCanonicalMap· (
		_ dt: XSD.DurationValue
	) -> XSD.dayTimeDurationLexicalRep {
		let s = dt.·seconds·
		let sgn = s < 0 ? "-" : ""
		return XSD.dayTimeDurationLexicalRep(sgn + "P" + String(XSD.·duDayTimeCanonicalFragmentMap·(abs(s))))!
	}

}
