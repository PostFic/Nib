import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.scientificNotationNumeral` to its numerical value.
	///
	///  +  Parameters:
	///      +  N:
	///         A `XSD.scientificNotationNumeral`.
	///
	///  +  Returns:
	///     A `XSD.DecimalNumber`.
	///
	/// `N` necessarily consists of an instance of either
	///   `XSD.noDecimalPtNumeral` or `XSD.decimalPtNumeral`, either an
	///   `"e"` or an `"E"`, and then an instance of
	///   `XSD.noDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-sciVal>
	///
	///  +  Note:
	///     The definition provided by the XSD specification is
	///       incorrect; it uses `XSD.·unsignedDecimalPtMap·` to
	///       calculate exponents, rather than `XSD.·noDecimalMap·`.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·scientificMap·(
		_ N: XSD.scientificNotationNumeral
	) -> XSD.DecimalNumber {
		let parts = String(describing: N).split(
			maxSplits: 1,
			omittingEmptySubsequences: false
		) { $0 == "e" || $0 == "E" }
		let E = XSD.noDecimalPtNumeral(parts[1])!
		if parts[0].contains(".") {
			let C = XSD.decimalPtNumeral(parts[0])!
			let ·decimalPtMap·C = XSD.·decimalPtMap·(C)
			return XSD.DecimalNumber(
				sign: ·decimalPtMap·C.sign,
				exponent: Int(XSD.·noDecimalMap·(E)),
				significand: ·decimalPtMap·C.magnitude
			)
		} else {
			let C = XSD.noDecimalPtNumeral(parts[0])!
			let ·noDecimalMap·C = XSD.·noDecimalMap·(C)
			return XSD.DecimalNumber(
				sign: ·noDecimalMap·C < 0 ? .minus : .plus,
				exponent: Int(XSD.·noDecimalMap·(E)),
				significand: XSD.DecimalNumber(
					·noDecimalMap·C.magnitude
				)
			)
		}
	}

}
