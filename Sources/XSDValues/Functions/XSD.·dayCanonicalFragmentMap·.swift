import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the `·day·` property of a
	///   `XSDDate·timeSevenPropertyValue`, onto a `XSD.dayFrag`, part
	///   of a `XSDDate·timeSevenPropertyValue`’s lexical
	///   representation.
	///
	///  +  parameters:
	///      +  d:
	///         An `XSD.Integer` between 1 and 31 inclusive.
	///
	///  +  returns:
	///     A `XSD.dayFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-daCanFragMap>
	@inlinable
	static func ·dayCanonicalFragmentMap· (
		_ d: XSD.Integer
	) -> XSD.dayFrag
	{ XSD.dayFrag(XSD.·unsTwoDigitCanonicalFragmentMap·(d))! }

}
