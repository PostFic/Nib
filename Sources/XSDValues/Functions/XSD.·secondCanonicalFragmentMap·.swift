import Foundation
import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer`, presumably the `·second·` property of a
	///   `XSDDate·timeSevenPropertyValue`, onto a `XSD.secondFrag`,
	///   part of a `XSDDate·timeSevenPropertyValue`’s lexical
	///   representation.
	///
	///  +  parameters:
	///      +  s:
	///         A nonnegative `XSD.DecimalNumber` less than 60.
	///
	///  +  returns:
	///     A `XSD.secondFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-seCanFragMap>
	///
	///  +  note:
	///     The XSD specification incorrectly specifies `s` as being
	///       less than 70; only values less than 60 should be used.
	@inlinable
	static func ·secondCanonicalFragmentMap· (
		_ s: XSD.DecimalNumber
	) -> XSD.secondFrag {
		if let integer = XSD.Integer(
			exactly: s as NSDecimalNumber
		) { return XSD.secondFrag(XSD.·unsTwoDigitCanonicalFragmentMap·(integer))! }
		else
		{ return XSD.secondFrag(String(XSD.·unsTwoDigitCanonicalFragmentMap·(XSD.·div·(s, 1))) + "." + String(XSD.·fractionDigitsCanonicalFragmentMap·(XSD.·mod·(s, 1))))! }
	}

}
