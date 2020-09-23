import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the `·month·` property of a
	///   `XSDDate·timeSevenPropertyValue`, onto a `XSD.monthFrag`,
	///   part of a `XSDDate·timeSevenPropertyValue`’s lexical
	///   representation.
	///
	///  +  parameters:
	///      +  m:
	///         An `XSD.Integer` between 1 and 12 inclusive.
	///
	///  +  returns:
	///     A `XSD.monthFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-moCanFragMap>
	@inlinable
	static func ·monthCanonicalFragmentMap·(
		_ m: XSD.Integer
	) -> XSD.monthFrag {
		return XSD.·unsTwoDigitCanonicalFragmentMap·(m)◊
	}

}
