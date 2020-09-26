import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duHourFrag` to an `XSD.Integer`, to be used when
	///   calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  H:
	///         A `XSD.duHourFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// `H` is necessarily the letter `"H"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duHrMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly expects a `D` prefixed
	///       with a `"D"` instead of an `H` followed by `"H"`, as
	///       described by the [duHourFrag] grammar.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·duHourFragmentMap· (
		_ H: XSD.duHourFrag
	) -> XSD.Integer {
		let N = String(H).dropLast()
		return XSD.·noDecimalMap·(XSD.noDecimalPtNumeral(N)!)
	}

}
