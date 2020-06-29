import XSD

public extension XSD {

	/// The set of finite‐length sequences of zero or more
	///   characters (as defined in [XML]) that match the [Char]
	///   production from [XML].
	///
	/// ````
	/// [1]   stringRep ::= Char*
	/// ````
	///
	/// [Char]: http://www.w3.org/TR/xml11/#NT-Char
	/// [XML]: http://www.w3.org/TR/xml11/
	final class stringRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			(\u{1}-\u{D7FF}|\
			\u{E000}-\u{FFFD}|\
			\u{10000}-\u{10FFFF})*
			"""

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
