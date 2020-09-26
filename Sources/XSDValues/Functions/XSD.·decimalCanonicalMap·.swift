import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalValue` to its canonical representation, a
	///   `XSD.decimalLexicalRep`.
	///
	///  +  parameters:
	///      +  d:
	///         A `XSD.DecimalValue`.
	///
	///  +  returns:
	///     A `XSD.decimalLexicalRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decimalCanmap>
	@inlinable
	static func ·decimalCanonicalMap· (
		_ d: XSD.DecimalValue
	) -> XSD.decimalLexicalRep {
		if let integer = d.integer
		{ return XSD.decimalLexicalRep(XSD.·noDecimalPtCanonicalMap·(integer))! }
		else
		{ return XSD.decimalLexicalRep(XSD.·decimalPtCanonicalMap·(d.decimalNumber!))! }
	}

}
