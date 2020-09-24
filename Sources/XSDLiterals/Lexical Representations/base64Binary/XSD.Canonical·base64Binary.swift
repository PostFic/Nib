import XSD

public extension XSD {

	/// A `XSD.Base64Binary` which contains no whitespace.
	///
	/// ````
	/// [39]   Canonical-base64Binary ::= CanonicalQuad* CanonicalPadded?
	/// ````
	///
	///  +  note:
	///     For some values, this canonical representation does not
	///       conform to [RFC 2045], which requires breaking with
	///       linefeeds at appropriate intervals.
	///     It does conform with [RFC 3548].
	///
	/// [RFC 2045]: http://www.ietf.org/rfc/rfc2045.txt
	/// [RFC 3548]: http://www.ietf.org/rfc/rfc3548.txt
	class Canonical·base64Binary: XSD.Base64Binary {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			(([A-Za-z0-9+/]{4})*(\
			[A-Za-z0-9+/]{3}[A-Za-z0-9+/]|\
			[A-Za-z0-9+/]{2}[AEIMQUYcgkosw048]=|\
			[A-Za-z0-9+/][AQgw]==))?
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
