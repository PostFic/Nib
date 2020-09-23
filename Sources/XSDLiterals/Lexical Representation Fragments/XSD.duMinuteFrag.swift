import XSD
import XSDRegularExpressions

public extension XSD {

	/// An integer minute, followed by the string `"M"`.
	///
	/// ````
	/// [10]   duMinuteFrag ::= unsignedNoDecimalPtNumeral 'M'
	/// ````
	final class duMinuteFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+M"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
