import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duYearFrag` to an `XSD.Integer`, to be used when
	///   calculating the `·months·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  Y:
	///         A `XSD.duYearFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// `Y` is necessarily the letter `"Y"` preceded by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duYrMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that `Y` consists
	///       of the letter `"Y"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as
	///       preceding.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·duYearFragmentMap·(
		_ Y: XSD.duYearFrag
	) -> XSD.Integer {
		let N = String(describing: Y).dropLast()
		return XSD.·noDecimalMap·(N◊)
	}

}
