import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the `·minute·` property of a
	///   `XSDDate·timeSevenPropertyValue`, onto a `XSD.minuteFrag`,
	///   part of a `XSDDate·timeSevenPropertyValue`’s lexical
	///   representation.
	///
	///  +  parameters:
	///      +  m:
	///         An `XSD.Integer` between 0 and 59 inclusive.
	///
	///  +  returns:
	///     A `XSD.minuteFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-miCanFragMap>
	@inlinable
	static func ·minuteCanonicalFragmentMap· (
		_ m: XSD.Integer
	) -> XSD.minuteFrag
	{ XSD.minuteFrag(XSD.·unsTwoDigitCanonicalFragmentMap·(m))! }

}
