import XSD
import XSDRegularExpressions

public extension XSD {

	/// Base64 characters.
	///
	/// ````
	/// [34]   B64char ::= [A-Za-z0-9+/]
	/// ````
	final class B64char: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[A-Za-z0-9+/]"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
