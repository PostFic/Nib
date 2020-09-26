import XSD

public extension XSD {

	/// Maps a `XSD.DecimalNumber` (`c` × 10^`e`) to successive
	///   approximations.
	///
	///  +  parameters:
	///      +  c:
	///         An `XSD.Integer`.
	///      +  e:
	///         An `XSD.Integer`.
	///      +  j:
	///         An `XSD.Integer`.
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
		return XSD.DecimalNumber(
			sign: .plus,
			exponent: Int(e),
			significand: XSD.·round·(XSD.DecimalNumber(c), j)
		)
	}

}
