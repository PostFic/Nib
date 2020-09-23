import XSD

public extension XSD {

	/// Maps each `XSD.DecimalNumber` to a `XSD.Sequence` of
	///   `XSD.DecimalNumber`s, to be used by `XSD.·fractionDigitSeq·`
	///   to ultimately create an `XSD.unsignedNoDecimalPtNumeral`.
	///
	///  +  parameters:
	///      +  f:
	///         A `XSD.DecimalNumber`.
	///
	///  +  returns:
	///     A `XSD.Sequence` of nonnegative `XSD.DecimalNumber`s.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitRemSeq>
	///
	///  +  note:
	///     The definition of `·FractionDigitRemainderSeq·` given by
	///       the XSD Datatypes specification is incorrect; it uses
	///       “minus” instead of “times”.
	///     Nib provides the correct implementation.
	@inlinable
	static func ·FractionDigitRemainderSeq·(
		_ f: XSD.DecimalNumber
	) -> XSD.Sequence<XSD.DecimalNumber> {
		return sequence(
			state: XSD.·mod·(abs(f), 1) * 10
		) { s_（j＋1） in
			let s_j = s_（j＋1） as! XSD.DecimalNumber
			s_（j＋1） = XSD.·mod·(s_j, 1) * 10
			return s_j
		}
	}

}
