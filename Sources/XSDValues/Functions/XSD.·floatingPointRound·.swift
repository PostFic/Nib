import Foundation
import XSD

public extension XSD {

	/// Rounds a `XSD.DecimalNumber` to the nearest floating‐point value.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatPtRound>
	///
	///  +  note:
	///     Nib cheats and relying on Foundations’s internal rounding, instead of implementing the algorithm described in the XSD Specification.
	///     Consequently, the second argument must be either 32 or 64, and the third and fourth arguments are ignored.
	///
	///  +  note:
	///     Nib does not actually make use of this function; it is provided solely for XSD completeness.
	@inlinable
	static func ·floatingPointRound· (
		_ nV: XSD.DecimalNumber,
		_ cWidth: XSD.Integer,
		_ eMin: XSD.Integer = 0,
		_ eMax: XSD.Integer = 0
	) -> XSD.DecimalNumber {
		switch cWidth {
		case 32:
			return (
				Float32(
					truncating: nV as NSDecimalNumber
				) as NSNumber
			).decimalValue
		case 64:
			return (
				Float64(
					truncating: nV as NSDecimalNumber
				) as NSNumber
			).decimalValue
		default:
			fatalError("Expected either 32 or 64, but got \(cWidth)")
		}
	}

}
