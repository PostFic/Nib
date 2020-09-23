import XSD

public extension XSD {

	/// The final four characters of a `XSD.Base64Binary` string.
	///
	/// ````
	/// [29]   B64final ::= B64finalquad | Padded16 | Padded8
	/// ````
	final class B64final: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			([A-Za-z0-9+/] ?){3}[A-Za-z0-9+/]|\
			([A-Za-z0-9+/] ?){2}[AEIMQUYcgkosw048] ?=|\
			[A-Za-z0-9+/] ?[AQgw] ?= ?=
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
