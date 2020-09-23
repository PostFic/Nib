import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.decimalLexicalRep` onto a `XSD.DecimalValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.decimalLexicalRep`.
	///
	///  +  returns:
	///     A `XSD.DecimalValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-decimalLexmap>
	@inlinable
	static func ·decimalLexicalMap·(
		_ LEX: XSD.decimalLexicalRep
	) -> XSD.DecimalValue {
		let d: XSD.DecimalNumber
		if let noDecimalPtNumeral: XSD.noDecimalPtNumeral = LEX◊? {
			d = XSD.DecimalNumber(
				XSD.·noDecimalMap·(noDecimalPtNumeral)
			)
		} else { d = XSD.·decimalPtMap·(LEX◊) }
		return XSD.DecimalValue(exactly: d)!
	}

}
