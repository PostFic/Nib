import XSD
import XSDRegularExpressions

public extension XSD {

	/// A single octet at the end of the data.
	///
	/// ````
	/// [32]   Padded8 ::= B64 B04 '=' #x20? '='
	/// ````
	final class Padded8: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[A-Za-z0-9+/] ?[AQgw] ?= ?="

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
