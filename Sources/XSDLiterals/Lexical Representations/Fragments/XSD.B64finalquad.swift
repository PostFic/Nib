import XSD

public extension XSD {

	/// Three octets of binary data without trailing space.
	///
	/// ````
	/// [30]   B64finalquad ::= (B64 B64 B64 B64char)
	/// ````
	final class B64finalquad: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "([A-Za-z0-9+/] ?){3}[A-Za-z0-9+/]"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
