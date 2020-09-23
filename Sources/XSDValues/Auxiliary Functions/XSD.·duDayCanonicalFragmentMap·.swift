import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the day normalized value from
	///   the `·seconds·` of a `XSD.DurationValue`, to a `XSD.duDayFrag`,
	///   a fragment of a `XSD.DurationValue` lexical representation.
	///
	///  +  parameters:
	///      +  d:
	///         A nonnegative `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.duDayFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duDCan>
	@inlinable
	static func ·duDayCanonicalFragmentMap·(
		_ d: XSD.Integer
	) -> XSD.duDayFrag {
		if d != 0 {
			return (XSD.·unsignedNoDecimalPtCanonicalMap·(d) + "D")◊
		} else { return ""◊ }
	}

}
