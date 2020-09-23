import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the `·hour·` property of a
	///   `XSDDate·timeSevenPropertyValue`, onto a `XSD.hourFrag`, part
	///   of a `XSDDate·timeSevenPropertyValue`’s lexical
	///   representation.
	///
	///  +  parameters:
	///      +  h:
	///         An `XSD.Integer` between 0 and 23 inclusive.
	///
	///  +  returns:
	///     A `XSD.hourFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-hrCanFragMap>
	@inlinable
	static func ·hourCanonicalFragmentMap·(
		_ h: XSD.Integer
	) -> XSD.hourFrag {
		return XSD.·unsTwoDigitCanonicalFragmentMap·(h)◊
	}

}
