import XSD
import XSDLiterals

public extension XSD {

	/// Maps the lexical representations of special values used with
	///   some numerical datatypes to those special values.
	///
	///  +  parameters:
	///      +  S:
	///         A `XSD.numericalSpecialRep`.
	///
	///  +  returns:
	///     A `XSD.SpecialValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-specRepVal>
	@inlinable
	static func ·specialRepValue·(
		_ S: XSD.numericalSpecialRep
	) -> XSD.SpecialValue {
		switch String(describing: S) {
		case "INF", "+INF":
			return .positiveInfinity
		case "-INF":
			return .negativeInfinity
		case "NaN":
			return .notANumber
		default:
			fatalError("Expected a special value, but got \(S).")
		}
	}

}
