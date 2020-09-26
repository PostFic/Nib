import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.Sequence` of `XSD.digit`s to the base‐10
	///   position‐weighted sum of their numerical values.
	///
	///  +  parameters:
	///      +  S:
	///         A finite `XSD.Sequence` of `XSD.digit`s.
	///
	///  +  returns:
	///     A nonnegative `XSD.Integer`, or `nil` if the argument is
	///       invalid.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-digitSeqVal>
	@inlinable
	static func ·digitSequenceValue· (
		_ S: XSD.Sequence <XSD.digit>
	) -> XSD.Integer {
		return S.reduce(
			into: 0 as XSD.Integer
		) { $0 = $0 * 10 + XSD.·digitValue·($1) }
	}

}
