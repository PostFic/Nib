import XSD
import XSDRegularExpressions

public extension XSD {

	/// The final four characters of a padded `XSD.Base64Binary`
	///   string, with no whitespace.
	///
	/// ````
	/// [41]   CanonicalPadded ::= B64char B64char B16char '=' | B64char B04char '=='
	/// ````
	final class CanonicalPadded: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			[A-Za-z0-9+/]{2}[AEIMQUYcgkosw048]=|\
			[A-Za-z0-9+/][AQgw]==
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
