import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalNumber` to an
	///   `XSD.unsignedDecimalPtNumeral`, its canonical representation.
	///
	///  +  parameters:
	///      +  n:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     An `XSD.unsignedDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsDecCanFragMap>
	@inlinable
	static func ·unsignedDecimalPtCanonicalMap·(
		_ n: XSD.DecimalNumber
	) -> XSD.unsignedDecimalPtNumeral {
		return (
			XSD.·unsignedNoDecimalPtCanonicalMap·(
				XSD.·div·(abs(n), 1)
			) + "." + XSD.·fractionDigitsCanonicalFragmentMap·(
				XSD.·mod·(abs(n), 1)
			)
		)◊
	}

}
