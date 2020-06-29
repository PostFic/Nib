import XSD

public extension XSD {

	/// A two‐octet at the end of the data.
	///
	/// ````
	/// [31]   Padded16 ::= B64 B64 B16 '='
	/// ````
	final class Padded16: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern =
		"([A-Za-z0-9+/] ?){2}[AEIMQUYcgkosw048] ?="

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
