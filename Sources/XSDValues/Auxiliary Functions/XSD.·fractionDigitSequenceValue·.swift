import XSD
import XSDLiterals

public extension XSD {

	/// Maps a `XSD.Sequence` of `XSD.digit`s to the inverse base‐10
	///   position‐weighted sum of their numerical values.
	///
	///  +  parameters:
	///      +  S:
	///         A finite `XSD.Sequence` of `XSD.digit`s.
	///
	///  +  returns:
	///     A nonnegative `XSD.DecimalNumber`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#f-fracDigitSeqVal>
	///
	///  +  note:
	///     The definition of `·fractionDigitSequenceValue·` given by
	///       the XSD Datatypes specification is incorrect; it uses
	///       “minus” instead of “times” and returns an integer when it
	///       should return a decimal number.
	///     Nib provides the correct implementation.       
	@inlinable
	static func ·fractionDigitSequenceValue·(
		_ S: XSD.Sequence<XSD.digit>
	) -> XSD.DecimalNumber {
		return S.reduce(
			into: 0 as XSD.DecimalNumber
		) { result, S_i in
			result = result * XSD.DecimalNumber(
				sign: .plus,
				exponent: -1,
				significand: 1
			) + XSD.DecimalNumber(XSD.·digitValue·(S_i))
		}
	}

}
