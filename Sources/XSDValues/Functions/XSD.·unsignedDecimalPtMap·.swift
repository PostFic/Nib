import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.unsignedDecimalPtNumeral` to its numerical value.
	///
	///  +  parameters:
	///      +  D:
	///         An `XSD.unsignedDecimalPtNumeral`.
	///
	///  +  returns:
	///     A nonnegative `XSD.DecimalNumber`.
	///
	/// `D` necessarily consists of an optional `XSD.Literal` matching
	///   `XSD.unsignedNoDecimalPtNumeral`, a decimal point, and then
	///   an optional `XSD.fracFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsDecVal>
	@inlinable
	static func ·unsignedDecimalPtMap·(
		_ D: XSD.unsignedDecimalPtNumeral
	) -> XSD.DecimalNumber {
		let parts = String(describing: D).split(
			separator: ".",
			maxSplits: 1,
			omittingEmptySubsequences: false
		)
		if parts.count == 1 {
			let N = XSD.unsignedNoDecimalPtNumeral(parts[0])!
			return XSD.DecimalNumber(XSD.·unsignedNoDecimalMap·(N))
		} else if parts[0] == "" {
			let F = XSD.fracFrag(parts[1])!
			return XSD.·fractionFragValue·(F)
		} else {
			let N = XSD.unsignedNoDecimalPtNumeral(parts[0])!
			let F = XSD.fracFrag(parts[1])!
			return XSD.DecimalNumber(XSD.·unsignedNoDecimalMap·(N))
				+ XSD.·fractionFragValue·(F)
		}
	}

}
