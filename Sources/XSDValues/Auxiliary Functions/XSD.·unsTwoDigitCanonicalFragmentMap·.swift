import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer` onto an `XSD.unsignedNoDecimalPtNumeral`
	///   which is always two digits.
	///
	///  +  parameters:
	///      +  i:
	///         A nonnegative `XSD.Integer` less than 100.
	///
	///  +  returns:
	///     An `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsTwoDigCanFragMap>
	@inlinable
	static func ·unsTwoDigitCanonicalFragmentMap· (
		_ i: XSD.Integer
	) -> XSD.unsignedNoDecimalPtNumeral
	{ XSD.unsignedNoDecimalPtNumeral(String(XSD.·digit·(XSD.·div·(i, 10))) + String(XSD.·digit·(XSD.·mod·(i, 10))))! }

}
