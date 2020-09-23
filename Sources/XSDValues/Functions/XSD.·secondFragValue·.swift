import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.secondFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.DecimalNumber`, presumably the `·second·`
	///   property of a `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  SE:
	///         A `XSD.secondFrag`.
	///
	///  +  returns:
	///     A `XSD.DecimalNumber`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-seMap>
	@inlinable
	static func ·secondFragValue·(
		_ SE: XSD.secondFrag
	) -> XSD.DecimalNumber {
		if String(describing: SE).contains(".") {
			return XSD.·unsignedDecimalPtMap·(SE◊)
		} else {
			return XSD.DecimalNumber(XSD.·unsignedNoDecimalMap·(SE◊))
		}
	}

}
