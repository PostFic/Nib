import XSD

public extension XSD {

	/// A Base64 character whose bit‐string value ends in `"00"`,
	///   optionally followed by a space.
	///
	/// ````
	/// [35]   B16 ::= B16char #x20?
	/// ````
	final class B16: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[AEIMQUYcgkosw048] ?"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
