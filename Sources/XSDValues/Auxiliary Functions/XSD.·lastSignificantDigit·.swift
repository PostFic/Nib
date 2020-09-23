import XSD

public extension XSD {

	/// Maps a `XSD.Sequence` of `XSD.Integer`s to the zero‐based index
	///   of its last nonzero element.
	///
	///  +  parameters:
	///      +  s:
	///         A `XSD.Sequence` of `XSD.Integer`s.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-lastSigDigit>
	@inlinable
	static func ·lastSignificantDigit·(
		_ s: XSD.Sequence<XSD.Integer>
	) -> XSD.Integer {
		let j = s.enumerated().first { $0.1 == 0 }?.0 ?? .max
		return XSD.Integer(j - 1)
	}

	/// Maps a `XSD.Sequence` of `XSD.DecimalNumber`s to the zero‐based
	///   index of its last nonzero element.
	///
	///  +  parameters:
	///      +  s:
	///         A `XSD.Sequence` of `XSD.DecimalNumber`s.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-lastSigDigit>
	///
	///  +  note:
	///     XSD actually only defines `·lastSignificantDigit·` for
	///       integers, but it clearly makes use of the function with
	///       decimal numbers as well.
	@inlinable
	static func ·lastSignificantDigit·(
		_ s: XSD.Sequence<XSD.DecimalNumber>
	) -> XSD.Integer {
		let j = s.enumerated().first { $0.1 == 0 }?.0 ?? .max
		return XSD.Integer(j - 1)
	}

}
