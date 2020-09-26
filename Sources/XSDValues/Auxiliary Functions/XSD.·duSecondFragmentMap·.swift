import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.duSecondFrag` to a `XSD.DecimalNumber`, to be used
	///   when calculating the `·seconds·` of a `XSD.DurationValue`.
	///
	///  +  parameters:
	///      +  S:
	///         A `XSD.duSecondFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.DecimalNumber`.
	///
	/// `S` is necessarily the letter `"S"` followed by a numeral.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duSeMap>
	///
	///  +  note:
	///     The XSD Specification incorrectly states that `S` consists
	///       of the letter `"S"` *followed* by a numeral.
	///     The grammars, however, clearly show the numeral as
	///       preceding.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·duSecondFragmentMap· (
		_ S: XSD.duSecondFrag
	) -> XSD.DecimalNumber {
		let N = String(S).dropLast()
		if N.contains(".")
		{ return XSD.·decimalPtMap·(XSD.decimalPtNumeral(N)!) }
		else
		{ return XSD.DecimalNumber(XSD.·noDecimalMap·(XSD.noDecimalPtNumeral(N)!)) }
	}

}
