import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the `·year·` property of a
	///   `XSDDate·timeSevenPropertyValue`, onto a `XSD.yearFrag`,
	///   part of a `XSDDate·timeSevenPropertyValue`’s lexical
	///   representation.
	///
	///  +  parameters:
	///      +  y:
	///         An `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.yearFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-yrCanFragMap>
	@inlinable
	static func ·yearCanonicalFragmentMap· (
		_ y: XSD.Integer
	) -> XSD.yearFrag
	{ abs(y) > 9999 ? XSD.yearFrag(XSD.·noDecimalPtCanonicalMap·(y))! : XSD.yearFrag(XSD.·fourDigitCanonicalFragmentMap·(y))! }

}
