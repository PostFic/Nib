import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.decimalPtNumeral` to its numerical value.
	///
	///  +  parameters:
	///      +  N:
	///         A `XSD.decimalPtNumeral`.
	///
	///  +  returns:
	///     A `XSD.DecimalNumber`.
	///
	/// `N` necessarily consists of an optional sign (`"+"` or `"-"`)
	///   and then an instance of `XSD.unsignedDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decVal>
	@inlinable
	static func ·decimalPtMap· (
		_ N: XSD.decimalPtNumeral
	) -> XSD.DecimalNumber {
		let first = String(N).first
		let U = first == "-" || first == "+" ? XSD.unsignedDecimalPtNumeral(String(N).dropFirst())! : XSD.unsignedDecimalPtNumeral(N)!
		return first == "-" ? -1 * XSD.·unsignedDecimalPtMap·(U) : XSD.·unsignedDecimalPtMap·(U)
	}

}
