import XSD

public extension XSD {

	/// An decimal number second, followed by the string `"S"`.
	///
	/// ````
	/// [11]   duSecondFrag ::= (unsignedNoDecimalPtNumeral | unsignedDecimalPtNumeral) 'S'
	/// ````
	///
	///  +  note:
	///     The XSD specification gives an incorrect regex: The seconds
	///       component is allowed to have a leading decimal.
	///     Nib provides the correct implementation (but note that
	///       durations with a leading decimal in their seconds value
	///       may not be interoperable).
	final class duSecondFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern =
			#"([0-9]+|[0-9]+\.[0-9]*|\.[0-9]+)S"#

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
