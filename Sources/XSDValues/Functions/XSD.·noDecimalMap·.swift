import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.noDecimalPtNumeral` to its numerical value.
	///
	///  +  parameters:
	///      +  N:
	///         A `XSD.noDecimalPtNumeral`.
	///
	///  +  returns:
	///     An `XSD.Integer`.
	///
	/// `N` necessarily consists of an optional sign (`"+"` or `"-"`)
	///   and then an `XSD.unsignedNoDecimalPtNumeral`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-noDecVal>
	@inlinable
	static func ·noDecimalMap·(
		_ N: XSD.noDecimalPtNumeral
	) -> XSD.Integer {
		let U: XSD.unsignedNoDecimalPtNumeral
		let first = String(describing: N).first
		if first == "-" || first == "+" {
			U = String(describing: N).dropFirst()◊
		}
		else { U = N◊ }
		if first == "-" { return -1 * XSD.·unsignedNoDecimalMap·(U) }
		else { return XSD.·unsignedNoDecimalMap·(U) }
	}

}
