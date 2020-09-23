import XSD
import XSDRegularExpressions

public extension XSD {

	/// Base64 characters whose bit‐string value ends in `"0000"`.
	///
	/// ````
	/// [38]   B04char ::= [AQgw]
	/// ````
	final class B04char: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[AQgw]"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
