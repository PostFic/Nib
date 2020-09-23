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
	static func ·scientificCanonicalMap·(
		_ i: XSD.DecimalNumber
	) -> XSD.scientificNotationNumeral {
		if i < 0 {
			return ("-" + XSD.·unsignedScientificCanonicalMap·(-i))◊
		} else { return XSD.·unsignedScientificCanonicalMap·(i)◊ }
	}

}
