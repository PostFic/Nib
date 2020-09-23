import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duMinuteFrag` to an `XSD.Integer`, to be used when
	///   calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  M:
	///         A `XSD.duMinuteFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// `M` is necessarily the letter `"M"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duMiMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that `M` consists
	///       of the letter `"M"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as
	///       preceding.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·duMinuteFragmentMap·(
		_ M: XSD.duMinuteFrag
	) -> XSD.Integer {
		let N = String(describing: M).dropLast()
		return XSD.·noDecimalMap·(N◊)
	}

}
