import Foundation
import XSD

public extension XSD {

	/// Maps each `XSD.DecimalNumber` to a `XSD.Sequence` of
	///   `XSD.Integer`s, to be used by
	///   `XSD.·fractionDigitsCanonicalFragmentMap·` to ultimately
	///   create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	///  +  parameters:
	///      +  f:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.Sequence` of nonnegative `XSD.Integer`s where each
	///       element has a magnitude between 0 and 9 inclusive.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracDigitSeq>
	@inlinable
	static func ·fractionDigitSeq· (
		_ f: XSD.DecimalNumber
	) -> XSD.Sequence <XSD.Integer> {
		return sequence(
			state: XSD.·FractionDigitRemainderSeq·(f)
		) { state in
			var nextState = state as! XSD.Sequence <XSD.DecimalNumber>
			let ·FractionDigitRemainderSeq·f_j = nextState.next()!
			state = nextState
			return XSD.·div·(·FractionDigitRemainderSeq·f_j, 1)
		}
	}

}
