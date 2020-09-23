import XSD

public extension XSD {

	/// An integer hour, followed by the string `"H"`.
	///
	/// ````
	/// [9]   duHourFrag ::= unsignedNoDecimalPtNumeral 'H'
	/// ````
	final class duHourFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+H"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
