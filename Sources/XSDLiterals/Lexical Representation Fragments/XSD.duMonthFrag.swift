import XSD
import XSDRegularExpressions

public extension XSD {

	/// An integer month, followed by the string `"M"`.
	///
	/// ````
	/// [7]   duMonthFrag ::= unsignedNoDecimalPtNumeral 'M'
	/// ````
	final class duMonthFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+M"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
