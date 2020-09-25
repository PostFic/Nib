import XSD

public extension XSD {

	/// Three octets of binary data.
	///
	/// ````
	/// [28]   B64quad ::= (B64 B64 B64 B64)
	/// ````
	final class B64quad: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "([A-Za-z0-9+/] ?){4}"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
