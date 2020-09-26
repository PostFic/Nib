import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.monthFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.Integer`, presumably the `·month·` property of a
	///   `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  MO:
	///         A `XSD.monthFrag`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-moMap>
	@inlinable
	static func ·monthFragValue· (
		_ MO: XSD.monthFrag
	) -> XSD.Integer
	{ XSD.·unsignedNoDecimalMap·(XSD.unsignedNoDecimalPtNumeral(MO)!) }

}
