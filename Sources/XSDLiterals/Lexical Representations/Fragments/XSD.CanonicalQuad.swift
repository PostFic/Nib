import XSD

public extension XSD {

	/// Three octets of binary data, with no whitespace.
	///
	/// ````
	/// [40]   CanonicalQuad ::= B64char B64char B64char B64char
	/// ````
	final class CanonicalQuad: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[A-Za-z0-9+/]{4}"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
