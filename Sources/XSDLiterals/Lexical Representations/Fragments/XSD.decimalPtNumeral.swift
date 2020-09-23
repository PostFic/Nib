import XSD

public extension XSD {

	/// A possibly‐signed decimal number.
	///
	/// ````
	/// [51]   decimalPtNumeral ::= ('+' | '-')? unsignedDecimalPtNumeral
	/// ````
	final class decimalPtNumeral: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern =
			#"(\+|-)?([0-9]+\.[0-9]*|\.[0-9]+)"#

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
