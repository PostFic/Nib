import XSD

public extension XSD {

	/// Maps each `XSD.Integer` to a `XSD.Sequence` of `XSD.Integer`s,
	///   to be used by `XSD.·digitSeq·` to ultimately create an
	///   `XSD.unsignedNoDecimalPtNumeral`.
	///
	///  +  parameters:
	///      +  i:
	///         An `XSD.Integer`.
	///
	///  +  returns:
	///     A `XSD.Sequence` of positive `XSD.Integer`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitRemSeq>
	@inlinable
	static func ·digitRemainderSeq·(
		_ i: XSD.Integer
	) -> XSD.Sequence<XSD.Integer> {
		return sequence(state: abs(i)) { s_（j＋1） in
			let s_j = s_（j＋1） as! XSD.Integer
			s_（j＋1） = XSD.·div·(s_j, 10)
			return s_j
		}
	}

}
