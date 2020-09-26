import XSD
import XSDLiterals

public extension XSD {

	/// Maps an `XSD.unsignedNoDecimalPtNumeral` to its numerical
	///   value.
	///
	///  +  parameters:
	///      +  N:
	///         An `XSD.unsignedNoDecimalPtNumeral`.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// `N` is the left‐to‐right concatenation of a finite
	///   `XSD.Sequence` of `XSD.digit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-unsNoDecVal>
	@inlinable
	static func ·unsignedNoDecimalMap· (
		_ N: XSD.unsignedNoDecimalPtNumeral
	) -> XSD.Integer {
		return XSD.·digitSequenceValue·(
			sequence(
				state: String(N).makeIterator()
			) { state in
				var nextState = state as! String.Iterator
				guard let S_i = nextState.next()
				else
				{ return nil }
				state = nextState
				return XSD.digit(String(S_i))!
			}
		)
	}

}
