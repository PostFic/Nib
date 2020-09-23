import XSD

public extension XSD {

	/// An unsigned decimal number.
	///
	/// ````
	/// [49]   unsignedDecimalPtNumeral ::= (unsignedNoDecimalPtNumeral '.' fracFrag?) | ('.' fracFrag)
	/// ````
	final class unsignedDecimalPtNumeral: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"[0-9]+\.[0-9]*|\.[0-9]+"#

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
