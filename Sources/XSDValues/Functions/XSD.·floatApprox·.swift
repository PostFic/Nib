import XSD

public extension XSD {

	/// Maps a `XSD.DecimalNumber` (`c` × 10^`e`) to successive approximations.
	///
	///  +  parameters:
	///      +  c:
	///         A nonnegative `XSD.Integer`.
	///      +  e:
	///         An `XSD.Integer`.
	///      +  j:
	///         A nonnegative `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.DecimalNumber`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatApprox>
	@inlinable
	static func ·floatApprox· (
		_ c: XSD.Integer,
		_ e: XSD.Integer,
		_ j: XSD.Integer
	) -> XSD.DecimalNumber {
		guard c >= 0 else
		{ fatalError("Expected a nonnegative integer, but got \(c).") }
		guard j >= 0 else
		{ fatalError("Expected a nonnegative integer, but got \(j).") }
		return XSD.DecimalNumber(
			sign: .plus,
			exponent: Int(e),
			significand: XSD.·round·(XSD.DecimalNumber(c), j)
		)
	}

}
