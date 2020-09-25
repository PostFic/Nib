import XSD

public extension XSD {

	/// A two‐digit minute.
	///
	/// ````
	/// [60]   minuteFrag ::= [0-5] digit
	/// ````
	final class minuteFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-5][0-9]"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
