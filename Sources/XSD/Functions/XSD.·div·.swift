import Foundation

public extension XSD {

	/// The greatest integer less than or equal to `m` / `n`.
	///
	///  +  parameters:
	///      +  m:
	///         A `XSD.DecimalNumber`.
	///      +  n:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.Integer`.
	@inlinable
	static func ·div· (
		_ m: XSD.DecimalNumber,
		_ n: XSD.DecimalNumber
	) -> XSD.Integer {
		return XSD.Integer(
			exactly: (m as NSDecimalNumber).dividing(
				by: n as NSDecimalNumber,
				withBehavior: NSDecimalNumberHandler(
					roundingMode: .down,
					scale: 0,
					raiseOnExactness: false,
					raiseOnOverflow: true,
					raiseOnUnderflow: true,
					raiseOnDivideByZero: true
				)
			)
		)!
	}

	/// The greatest integer less than or equal to `m` / `n`.
	///
	///  +  parameters:
	///      +  m:
	///         An `XSD.Integer`.
	///      +  n:
	///         An `XSD.Integer`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	@inlinable
	static func ·div· (
		_ m: XSD.Integer,
		_ n: XSD.Integer
	) -> XSD.Integer
	{ m / n }

}
