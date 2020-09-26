import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duMonthFrag` to an `XSD.Integer`, to be used when
	///   calculating the `·months·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  M:
	///         A `XSD.duMonthFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// `M` is necessarily the letter `"M"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duMoMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that `M` consists
	///       of the letter `"M"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as
	///       preceding.
	///     Nib provides the correct implementation.
	///
	///  +  note:
	///     The XSD Specification improperly defines `M` as being a
	///       `XSD.duYearFrag`.
	///     This has no impact on the underlying algorithm, which
	///       properly assumes a `XSD.duMonthFrag` instead.
	@inlinable
	static func ·duMonthFragmentMap· (
		_ M: XSD.duMonthFrag
	) -> XSD.Integer {
		let N = String(M).dropLast()
		return XSD.·noDecimalMap·(XSD.noDecimalPtNumeral(N)!)
	}

}
