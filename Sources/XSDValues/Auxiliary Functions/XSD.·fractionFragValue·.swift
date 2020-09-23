import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.fracFrag` to the appropriate fractional
	///   `XSD.DecimalNumber`.
	///
	///  +  parameters:
	///      +  N:
	///         A `XSD.fracFrag`.
	///
	///  +  returns:
	///     A nonnegative `XSD.DecimalNumber`.
	///
	/// `N` is necessarily the left‐to‐right concatenation of a
	///   finite `XSD.Sequence` of `XSD.digit`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracFragVal>
	@inlinable
	static func ·fractionFragValue·(
		_ N: XSD.fracFrag
	) -> XSD.DecimalNumber {
		return XSD.·fractionDigitSequenceValue·(
			sequence(
				state: String(describing: N).makeIterator()
			) { state in
				var nextState = state as! String.Iterator
				guard let S_i = nextState.next()
				else { return nil }
				state = nextState
				return XSD.digit(String(S_i))!
			}
		)
	}

}
