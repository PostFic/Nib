import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.floatRep` onto a `XSD.FloatValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.floatRep`.
	///
	///  +  returns:
	///     A `XSD.FloatValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatLexmap>
	@inlinable
	static func ·floatLexicalMap·(
		_ LEX: XSD.floatRep
	) -> XSD.FloatValue {
		if let numericalSpecialRep: XSD.numericalSpecialRep = LEX◊? {
			return XSD.FloatValue(
				exactly: XSD.·specialRepValue·(numericalSpecialRep)
			)!
		} else {
			let nV: XSD.DecimalNumber
			if let noDecimalPtNumeral: XSD.noDecimalPtNumeral = LEX◊? {
				nV = XSD.DecimalNumber(
					XSD.·noDecimalMap·(noDecimalPtNumeral)
				)
			} else if
				let decimalPtNumeral: XSD.decimalPtNumeral = LEX◊?
			{ nV = XSD.·decimalPtMap·(decimalPtNumeral) }
			else { nV = XSD.·scientificMap·(LEX◊) }
			if nV == 0 {
				guard let first = String(describing: LEX).first
				else { return 0 }
				if first == "-" { return -0.0 }
				else { return 0.0 }
			} else { return XSD.FloatValue(truncating: nV) }
		}
	}

}
