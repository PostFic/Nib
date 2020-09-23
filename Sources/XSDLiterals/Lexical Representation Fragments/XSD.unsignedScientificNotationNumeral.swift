import XSD
import XSDRegularExpressions

public extension XSD {

	/// An unsigned decimal number in scientific notation.
	///
	/// ````
	/// [52]   unsignedScientificNotationNumeral ::= (unsignedNoDecimalPtNumeral | unsignedDecimalPtNumeral) ('e' | 'E') noDecimalPtNumeral
	/// ````
	final class unsignedScientificNotationNumeral: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern =
			#"([0-9]+(\.[0-9]*)?|\.[0-9]+)[Ee](\+|-)?[0-9]+"#

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
