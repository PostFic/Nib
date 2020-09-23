import XSD
import XSDLiterals

public extension XSD {

	/// Maps three `XSD.Number`s, presumably the hour, minute, and
	///   second normalized values from the `·seconds·` of a
	///   `XSD.DurationValue`, to a `XSD.duTimeFrag`, a fragment of a
	///   `XSD.DurationValue` lexical representation.
	///
	///  +  parameters:
	///      +  h:
	///         A nonnegative `XSD.Integer`.
	///      +  m:
	///         A nonnegative `XSD.Integer`.
	///      +  s:
	///         A nonnegative `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.duTimeFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duTCan>
	@inlinable
	static func ·duTimeCanonicalFragmentMap·(
		_ h: XSD.Integer,
		_ m: XSD.Integer,
		_ s: XSD.DecimalNumber
	) -> XSD.duTimeFrag {
		if h != 0 || m != 0 || s != 0 {
			return (
				"T"
					+ XSD.·duHourCanonicalFragmentMap·(h)
					+ XSD.·duMinuteCanonicalFragmentMap·(m)
					+ XSD.·duSecondCanonicalFragmentMap·(s)
			)◊
		} else { return ""◊ }
	}

}
