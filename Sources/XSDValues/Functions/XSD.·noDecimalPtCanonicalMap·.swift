import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer` to a `XSD.noDecimalPtNumeral`, its
	///   canonical representation.
	///
	///  +  parameters:
	///      +  i:
	///         An `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.noDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-noDecCanMap>
	@inlinable
	static func ·noDecimalPtCanonicalMap·(
		_ i: XSD.Integer
	) -> XSD.noDecimalPtNumeral {
		if i < 0 {
			return ( "-" + XSD.·unsignedNoDecimalPtCanonicalMap·(-i))◊
		} else { return XSD.·unsignedNoDecimalPtCanonicalMap·(i)◊ }
	}

}
