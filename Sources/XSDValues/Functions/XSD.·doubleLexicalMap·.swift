import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.doubleRep` onto a `XSD.DoubleValue`.
	///
	///  +  parameters:
	///      +  LEX:
	///         A `XSD.doubleRep`.
	///
	///  +  returns:
	///     A `XSD.DoubleValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-doubleLexmap>
	@inlinable
	static func ·doubleLexicalMap·(
		_ LEX: XSD.doubleRep
	) -> XSD.DoubleValue {
		if let numericalSpecialRep: XSD.numericalSpecialRep = LEX◊? {
			return XSD.·specialRepValue·(numericalSpecialRep)◊
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
			} else { return XSD.DoubleValue(truncating: nV) }
		}
	}

}
