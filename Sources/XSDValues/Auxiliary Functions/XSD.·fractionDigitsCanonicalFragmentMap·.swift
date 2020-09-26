import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalNumber` to a `XSD.fracFrag`, to be used by
	///   `XSD.unsignedDecimalPtCanonicalMap` to ultimately create
	///   an `XSD.unsignedNoDecimalPtNumeral`.
	///
	///  +  parameters:
	///      +  f:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.fracFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracDigitSeq>
	@inlinable
	static func ·fractionDigitsCanonicalFragmentMap· (
		_ f: XSD.DecimalNumber
	) -> XSD.fracFrag {
		var ·fractionDigitSeq·f = XSD.·fractionDigitSeq·(f)
		let ·lastSignificantDigit·FractionDigitRemainderSeq·f = XSD.·lastSignificantDigit·(XSD.·FractionDigitRemainderSeq·(f))
		var result: Array <String> = []
		result.reserveCapacity(Int(·lastSignificantDigit·FractionDigitRemainderSeq·f))
		for _ in 0...·lastSignificantDigit·FractionDigitRemainderSeq·f {
			result += CollectionOfOne(String(XSD.·digit·(·fractionDigitSeq·f.next()!)))
		}
		return XSD.fracFrag(result.joined())!
	}

}
