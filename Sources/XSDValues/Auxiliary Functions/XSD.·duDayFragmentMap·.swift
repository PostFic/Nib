import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duDayFrag` to an `XSD.Integer`, to be used when
	///   calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  D:
	///         A `XSD.duDayFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// `D` is necessarily the letter `"D"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDaMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that `D` consists
	///       of the letter `"D"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as
	///       preceding.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·duDayFragmentMap· (
		_ D: XSD.duDayFrag
	) -> XSD.Integer {
		let N = String(D).dropLast()
		return XSD.·noDecimalMap·(XSD.noDecimalPtNumeral(N)!)
	}

}
