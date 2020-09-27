import XSD

public extension XSD {

	/// Maps a `XSD.DecimalNumber` to that value rounded by some power of 10, as an `XSD.Integer`.
	///
	///  +  parameters:
	///      +  n:
	///         A `XSD.DecimalNumber`.
	///      +  k:
	///         A nonnegative `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.DecimalNumber`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-round>
	@inlinable
	static func ·round· (
		_ n: XSD.DecimalNumber,
		_ k: XSD.Integer
	) -> XSD.DecimalNumber {
		guard k >= 0 else
		{ fatalError("Expected a nonnegative integer, but got \(k).") }
		return XSD.DecimalNumber(
			sign: n.sign,
			exponent: Int(k),
			significand: XSD.DecimalNumber(
				XSD.·div·(
					XSD.DecimalNumber(
						sign: n.sign,
						exponent: Int(-k),
						significand: n
					) + 0.5,
					1
				)
			)
		)
	}

}
