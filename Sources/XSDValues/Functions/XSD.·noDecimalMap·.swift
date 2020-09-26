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
	static func ·noDecimalMap· (
		_ N: XSD.noDecimalPtNumeral
	) -> XSD.Integer {
		let first = String(N).first
		let U = first == "-" || first == "+" ? XSD.unsignedNoDecimalPtNumeral(String(N).dropFirst())! : XSD.unsignedNoDecimalPtNumeral(N)!
		return first == "-" ? -1 * XSD.·unsignedNoDecimalMap·(U) : XSD.·unsignedNoDecimalMap·(U)
	}

}
