import XSD

public extension XSD {

	/// A Base64 character whose bit‐string value ends in `"0000"`,
	///   optionally followed by a space.
	///
	/// ````
	/// [37]   B04 ::= B04char #x20?
	/// ````
	final class B04: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[AQgw] ?"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
