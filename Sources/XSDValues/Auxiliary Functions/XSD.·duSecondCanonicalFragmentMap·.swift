import Foundation
import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.DecimalNumber`, presumably the second normalized
	///   value from the `·seconds·` of a `XSD.DurationValue`, to a
	///   `XSD.duSecondFrag`, a fragment of a `XSD.DurationValue`
	///   lexical representation.
	///
	///  +  parameters:
	///      +  s:
	///         A nonnegative `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.duSecondFrag`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-duSCan>
	@inlinable
	static func ·duSecondCanonicalFragmentMap· (
		_ s: XSD.DecimalNumber
	) -> XSD.duSecondFrag {
		if s != 0 {
			if let integer = XSD.Integer(
				exactly: s as NSNumber
			) { return XSD.duSecondFrag(String(XSD.·unsignedNoDecimalPtCanonicalMap·(integer)) + "S")! }
			else { return XSD.duSecondFrag(String(XSD.·unsignedDecimalPtCanonicalMap·(s)) + "S")! }
		} else
		{ return XSD.duSecondFrag()! }
	}

}
