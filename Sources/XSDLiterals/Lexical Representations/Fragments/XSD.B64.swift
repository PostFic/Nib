import XSD

public extension XSD {

	/// A Base64 character, optionally followed by a space.
	///
	/// ````
	/// [33]   B64 ::= B64char #x20?
	/// ````
	final class B64: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[A-Za-z0-9+/] ?"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
