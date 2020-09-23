import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalNumber` to a `XSD.decimalPtNumeral`, its
	///   canonical representation.
	///
	///  +  parameters:
	///      +  n:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.decimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decCanFragMap>
	@inlinable
	static func ·decimalPtCanonicalMap·(
		_ n: XSD.DecimalNumber
	) -> XSD.decimalPtNumeral {
		if n < 0 {
			return ("-" + XSD.·unsignedDecimalPtCanonicalMap·(-n))◊
		} else { return XSD.·unsignedDecimalPtCanonicalMap·(n)◊ }
	}

}
