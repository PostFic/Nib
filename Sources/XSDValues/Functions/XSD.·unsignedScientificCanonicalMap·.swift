import Foundation
import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalNumber` to a
	///   `XSD.unsignedScientificNotationNumeral`, its canonical
	///   representation.
	///
	///  +  parameters:
	///      +  n:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     An `XSD.unsignedScientificNotationNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsSciCanFragMap>
	///
	///  +  note:
	///     Nib’s implementation of this function “cheats” and gets the
	///       length of the (decimal) string representation of the
	///       significand to calculate `log(n) div 1`.
	///     Swift does not have a general `log10` available for use
	///       with nonbinary decimal numbers.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsSciCanFragMap>
	@inlinable
	static func ·unsignedScientificCanonicalMap· (
		_ n: XSD.DecimalNumber
	) -> XSD.unsignedScientificNotationNumeral {
		let ·div·（log·n），1 = Int16(String(describing: n.significand).count + n.exponent - 1)
		return XSD.unsignedScientificNotationNumeral(
			String(
				XSD.·unsignedDecimalPtCanonicalMap·(
					(abs(n) as NSDecimalNumber).multiplying(
						byPowerOf10: -·div·（log·n），1
					) as XSD.DecimalNumber
				)
			) + "E" + String(XSD.·noDecimalPtCanonicalMap·(XSD.Integer(·div·（log·n），1)))
		)!
	}

}
