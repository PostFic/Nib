import XSD

public extension XSD {

	/// An integer day, followed by the string `"D"`.
	///
	/// ````
	/// [8]   duDayFrag ::= unsignedNoDecimalPtNumeral 'D'
	/// ````
	final class duDayFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+D"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
