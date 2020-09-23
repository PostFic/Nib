import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.minuteFrag`, part of a
	///   `XSDDate·timeSevenPropertyModel`’s lexical representation,
	///   onto an `XSD.Integer`, presumably the `·minute·` property of
	///   a `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  MI:
	///         A `XSD.minuteFrag`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-dt-miMap>
	@inlinable
	static func ·minuteFragValue·(
		_ MI: XSD.minuteFrag
	) -> XSD.Integer { return XSD.·unsignedNoDecimalMap·(MI◊) }

}
