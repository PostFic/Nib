import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.dayFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.Integer`, presumably the `·day·` property of a
	///   `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  DA:
	///         A `XSD.dayFrag`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-daMap>
	@inlinable
	static func ·dayFragValue·(
		_ DA: XSD.dayFrag
	) -> XSD.Integer { return XSD.·unsignedNoDecimalMap·(DA◊) }

}
