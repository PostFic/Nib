import XSD

public extension XSD {

	/// A possibly‐signed decimal number in scientific notation.
	///
	/// ````
	/// [53]   scientificNotationNumeral ::= ('+' | '-')? unsignedScientificNotationNumeral
	/// ````
	final class scientificNotationNumeral: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern =
			#"(\+|-)?([0-9]+(\.[0-9]*)?|\.[0-9]+)[Ee](\+|-)?[0-9]+"#

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
