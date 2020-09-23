import XSD

public extension XSD {

	/// Limited to the 65 characters of the Base64 Alphabet defined in
	///   [RFC 3548], i.e., a‐z, A‐Z, 0‐9, the plus sign (+), the
	///   forward slash (/) and the equal sign (=), together with the
	///   space character (#x20).
	/// No other characters are allowed.
	///
	/// For compatibility with older mail gateways, [RFC 2045] suggests
	///   that Base64 data should have lines limited to at most 76
	///   characters in length.
	/// This line‐length limitation is not required by [RFC 3548] and
	///   is not mandated in the lexical representations of
	///   base64Binary data.
	///
	/// ````
	/// [27]   Base64Binary ::= (B64quad* B64final)?
	/// ````
	///
	///  +  note:
	///     This grammar requires the number of non‐whitespace
	///       characters in the lexical representation to be a multiple
	///       of four, and for equals signs to appear only at the end
	///       of the lexical representation.
	///
	/// [RFC 2045]: http://www.ietf.org/rfc/rfc2045.txt
	/// [RFC 3548]: http://www.ietf.org/rfc/rfc3548.txt
	class Base64Binary: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			((([A-Za-z0-9+/] ?){4})*\
			(([A-Za-z0-9+/] ?){3}[A-Za-z0-9+/]|\
			([A-Za-z0-9+/] ?){2}[AEIMQUYcgkosw048] ?=|\
			[A-Za-z0-9+/] ?[AQgw] ?= ?=))?
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
