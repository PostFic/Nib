import XSD

public extension XSD {

	/// Maps each `XSD.Integer` to a `XSD.Sequence` of `XSD.Integer`s,
	///   to be used by `XSD.·unsignedNoDecimalPtCanonicalMap·` to
	///   ultimately create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	///  +  parameters:
	///      +  i:
	///         An `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.Sequence` of `XSD.Integer`s where each element has
	///       a magnitude between 0 and 9 inclusive.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitSeq>
	@inlinable
	static func ·digitSeq·(
		_ i: XSD.Integer
	) -> XSD.Sequence<XSD.Integer> {
		return sequence(state: XSD.·digitRemainderSeq·(i)) { state in
			var nextState = state as! XSD.Sequence<XSD.Integer>
			let ·digitRemainderSeq·i_j = nextState.next()!
			state = nextState
			return XSD.·mod·(·digitRemainderSeq·i_j, 10)
		}
	}

}
