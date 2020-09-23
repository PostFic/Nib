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
	static func ·decimalPtMap·(
		_ N: XSD.decimalPtNumeral
	) -> XSD.DecimalNumber {
		let U: XSD.unsignedDecimalPtNumeral
		let first = String(describing: N).first
		if first == "-" || first == "+" {
			U = String(describing: N).dropFirst()◊
		}
		else { U = N◊ }
		if first == "-" { return -1 * XSD.·unsignedDecimalPtMap·(U) }
		else { return XSD.·unsignedDecimalPtMap·(U) }
	}

}
