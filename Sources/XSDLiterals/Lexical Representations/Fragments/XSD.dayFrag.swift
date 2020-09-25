import XSD

public extension XSD {

	/// A two‐digit day.
	///
	/// ````
	/// [58]   dayFrag ::= ('0' [1-9]) | ([12] digit) | ('3' [01])
	/// ````
	final class dayFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "0[1-9]|[12][0-9]|3[01]"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
