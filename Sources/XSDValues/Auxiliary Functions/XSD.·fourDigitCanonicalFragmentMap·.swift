import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.Integer` onto an `XSD.noDecimalPtNumeral` which is
	///   always four digits.
	///
	///  +  parameters:
	///      +  i:
	///         An `XSD.Integer` greater than -10000 and less than
	///           10000.
	///
	///  +  returns:
	///     An `XSD.noDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fourDigCanFragMap>
	@inlinable
	static func ·fourDigitCanonicalFragmentMap·(
		_ i: XSD.Integer
	) -> XSD.noDecimalPtNumeral {
		if i < 0 {
			return (
				"-" + XSD.·unsTwoDigitCanonicalFragmentMap·(
					XSD.·div·(-i, 100)
				) + XSD.·unsTwoDigitCanonicalFragmentMap·(
					XSD.·mod·(-i, 100)
				)
			)◊
		} else {
			return (
				XSD.·unsTwoDigitCanonicalFragmentMap·(
					XSD.·div·(i, 100)
				) + XSD.·unsTwoDigitCanonicalFragmentMap·(
					XSD.·mod·(i, 100)
				)
			)◊
		}
	}

}
