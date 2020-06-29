import XSD

public extension XSD {

	/// Base64 characters whose bit‐string value ends in `"00"`.
	///
	/// ````
	/// [36]   B16char ::= [AEIMQUYcgkosw048]
	/// ````
	final class B16char: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[AEIMQUYcgkosw048]"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
