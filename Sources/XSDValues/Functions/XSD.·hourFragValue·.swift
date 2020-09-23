import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.hourFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.Integer`, presumably the `·hour·` property of a
	///   `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  HR:
	///         A `XSD.hourFrag`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-hrMap>
	@inlinable
	static func ·hourFragValue·(
		_ HR: XSD.hourFrag
	) -> XSD.Integer { return XSD.·unsignedNoDecimalMap·(HR◊) }

}
