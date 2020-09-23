import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.yearFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.Integer`, presumably the `·year·` property of a
	///   `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  YR:
	///         A `XSD.yearFrag`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-yrMap>
	@inlinable
	static func ·yearFragValue·(
		_ YR: XSD.yearFrag
	) -> XSD.Integer { return XSD.·noDecimalMap·(YR◊) }

}
