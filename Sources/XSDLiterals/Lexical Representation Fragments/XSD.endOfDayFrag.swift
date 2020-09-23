import XSD
import XSDRegularExpressions

public extension XSD {

	/// Midnight, written as the twenty‐fourth hour.
	///
	/// ````
	/// [62]   endOfDayFrag ::= '24:00:00' ('.' '0'+)?
	/// ````
	final class endOfDayFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"24:00:00(\.0+)?"#

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
