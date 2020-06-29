import XSD

public extension XSD {

	/// A possibly‐signed integer.
	///
	/// ````
	/// [47]   noDecimalPtNumeral ::= ('+' | '-')? unsignedNoDecimalPtNumeral
	/// ````
	final class noDecimalPtNumeral: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"(\+|-)?[0-9]+"#

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
