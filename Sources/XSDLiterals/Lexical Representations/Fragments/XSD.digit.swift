import XSD

public extension XSD {

	/// A single (decimal) digit.
	///
	/// ````
	/// [45]   digit ::= [0-9]
	/// ````
	final class digit: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
