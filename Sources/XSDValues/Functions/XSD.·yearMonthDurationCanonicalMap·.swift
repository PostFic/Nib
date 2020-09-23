import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DurationValue`’s `·months·` value to a
	///   `XSD.yearMonthDurationLexicalRep`.
	///
	///  +  parameters:
	///      +  ym:
	///         A `XSD.DurationValue` with a zero `·seconds·` value.
	///
	///  +  returns:
	///     A `XSD.yearMonthDurationLexicalRep`.
	///
	/// `XSD.yearMonthDurationCanonicalMap` is a restriction of
	///   `XSD.durationCanonicalMap`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-yearMonthDurationCanMap>
	@inlinable
	static func ·yearMonthDurationCanonicalMap·(
		_ ym: XSD.DurationValue
	) -> XSD.yearMonthDurationLexicalRep {
		let m = ym.·months·
		let sgn = m < 0 ? "-" : ""
		return (
			sgn + "P" + XSD.·duYearMonthCanonicalFragmentMap·(abs(m))
		)◊
	}

}
