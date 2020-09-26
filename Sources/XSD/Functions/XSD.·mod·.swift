import Foundation

public extension XSD {

	/// `m` − `n` × `XSD.·div·(m, n)`.
	///
	///  +  parameters:
	///      +  m:
	///         A `XSD.DecimalNumber`.
	///      +  n:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.DecimalNumber`.
	@inlinable
	static func ·mod· (
		_ m: XSD.DecimalNumber,
		_ n: XSD.DecimalNumber
	) -> XSD.DecimalNumber {
		return m - n * (
			(m as NSDecimalNumber).dividing(
				by: n as NSDecimalNumber,
				withBehavior: NSDecimalNumberHandler(
					roundingMode: .down,
					scale: 0,
					raiseOnExactness: false,
					raiseOnOverflow: true,
					raiseOnUnderflow: true,
					raiseOnDivideByZero: true
				)
			) as XSD.DecimalNumber
		)
	}

	/// `m` − `n` × `XSD.·div·(m, n)`.
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
	static func ·mod· (
		_ m: XSD.Integer,
		_ n: XSD.Integer
	) -> XSD.Integer
	{ m % n }

}
