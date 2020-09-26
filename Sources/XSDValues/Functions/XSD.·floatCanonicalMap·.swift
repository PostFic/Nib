import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.FloatValue` to its canonical representation, a
	///   `XSD.floatRep`.
	///
	///  +  parameters:
	///      +  f:
	///         A `XSD.FloatValue`.
	///
	///  +  returns:
	///     A `XSD.floatRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-floatCanmap>
	///
	///  +  note:
	///     This implementation cheats a bit, letting Swift determine
	///       the proper float approximation in its conversion to a
	///       `XSD.DecimalNumber`.
	@inlinable
	static func ·floatCanonicalMap· (
		_ f: XSD.FloatValue
	) -> XSD.floatRep {
		if let specialValue = f.specialValue {
			switch specialValue {
			case .positiveInfinity, .negativeInfinity, .notANumber:
				return XSD.floatRep(XSD.·specialRepCanonicalMap·(specialValue))!
			case .positiveZero:
				return XSD.floatRep("0.0E0")!
			case .negativeZero:
				return XSD.floatRep("-0.0E0")!
			}
		} else
		{ return XSD.floatRep(XSD.·scientificCanonicalMap·(f.decimalNumber!))! }
	}

}
