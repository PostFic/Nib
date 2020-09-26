import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the hour normalized value
	///   from the `·seconds·` of a `XSD.DurationValue`, to a
	///   `XSD.duHourFrag`, a fragment of a `XSD.DurationValue` lexical
	///   representation.
	///
	///  +  parameters:
	///      +  h:
	///         A nonnegative `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.duHourFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duHCan>
	@inlinable
	static func ·duHourCanonicalFragmentMap· (
		_ h: XSD.Integer
	) -> XSD.duHourFrag
	{ XSD.duHourFrag(h != 0 ? String(XSD.·unsignedNoDecimalPtCanonicalMap·(h)) + "H" : "")! }

}
