import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the minute normalized value
	///   from the `·seconds·` of a `XSD.DurationValue`, to a
	///   `XSD.duMinuteFrag`, a fragment of a `XSD.DurationValue`
	///   lexical representation.
	///
	///  +  parameters:
	///      +  m:
	///         A nonnegative `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.duMinuteFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duMCan>
	@inlinable
	static func ·duMinuteCanonicalFragmentMap·(
		_ m: XSD.Integer
	) -> XSD.duMinuteFrag {
		if m != 0 {
			return (XSD.·unsignedNoDecimalPtCanonicalMap·(m) + "M")◊
		} else { return ""◊ }
	}

}
