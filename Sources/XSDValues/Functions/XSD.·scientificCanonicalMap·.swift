import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalNumber` to a
	///   `XSD.scientificNotationNumeral`, its canonical
	///   representation.
	///
	///  +  parameters:
	///      +  n:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.scientificNotationNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-sciCanFragMap>
	@inlinable
	static func ·scientificCanonicalMap· (
		_ i: XSD.DecimalNumber
	) -> XSD.scientificNotationNumeral
	{ XSD.scientificNotationNumeral(i < 0 ? "-" + String(XSD.·unsignedScientificCanonicalMap·(-i)) : String(XSD.·unsignedScientificCanonicalMap·(i)))! }

}
