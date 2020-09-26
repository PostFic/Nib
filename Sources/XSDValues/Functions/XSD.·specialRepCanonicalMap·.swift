import XSD
import XSDLiterals

public extension XSD {

	/// Maps the special values used with some numeric datatypes to
	///   their canonical representations.
	///
	///  +  parameters:
	///      +  c:
	///         A `XSD.SpecialValue`.
	///
	///  +  returns:
	///     A `XSD.numericalSpecialRep`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-specValCanMap>
	@inlinable
	static func ·specialRepCanonicalMap· (
		_ c: XSD.SpecialValue
	) -> XSD.numericalSpecialRep {
		switch c {
		case .negativeInfinity:
			return XSD.numericalSpecialRep("-INF")!
		case .positiveInfinity:
			return XSD.numericalSpecialRep("INF")!
		case .notANumber:
			return XSD.numericalSpecialRep("NaN")!
		case .positiveZero:  //  not specified by XSD
			return XSD.numericalSpecialRep("0.0E0")!
		case .negativeZero:  //  not specified by XSD
			return XSD.numericalSpecialRep("-0.0E0")!
		}
	}

}
