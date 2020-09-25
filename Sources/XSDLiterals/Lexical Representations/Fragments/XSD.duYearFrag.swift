import XSD

public extension XSD {

	/// An integer year, followed by the string `"Y"`.
	///
	/// ````
	/// [6]   duYearFrag ::= unsignedNoDecimalPtNumeral 'Y'
	/// ````
	final class duYearFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+Y"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
