import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DoubleValue` to its canonical representation, a
	///   `XSD.doubleRep`.
	///
	///  +  parameters:
	///      +  f:
	///         A `XSD.DoubleValue`.
	///
	///  +  returns:
	///     A `XSD.doubleRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-doubleCanmap>
	///
	///  +  note:
	///     This implementation cheats a bit, letting Swift determine
	///       the proper float approximation in its conversion to a
	///       `XSD.DecimalNumber`.
	@inlinable
	static func ·doubleCanonicalMap·(
		_ f: XSD.DoubleValue
	) -> XSD.doubleRep {
		if let specialValue = f.specialValue {
			switch specialValue {
			case .positiveInfinity, .negativeInfinity, .notANumber:
				return XSD.·specialRepCanonicalMap·(specialValue)◊
			case .positiveZero:
				return "0.0E0"◊
			case .negativeZero:
				return "-0.0E0"◊
			}
		} else {
			return XSD.·scientificCanonicalMap·(f.decimalNumber!)◊
		}
	}

}
