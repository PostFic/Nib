import XSD
import XSDRegularExpressions

public extension XSD {

	/// Midnight, written as the twenty‐fourth hour.
	///
	/// ````
	/// [63]   timezoneFrag ::= 'Z' | ('+' | '-') (('0' digit | '1' [0-3]) ':' minuteFrag | '14:00')
	/// ````
	final class timezoneFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern =
			#"Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)"#

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
