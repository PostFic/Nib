import XSD

public extension XSD {

	/// An decimal number second, followed by the string `"S"`.
	///
	/// ````
	/// [11]   duSecondFrag ::= (unsignedNoDecimalPtNumeral | unsignedDecimalPtNumeral) 'S'
	/// ````
	final class duSecondFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"[0-9]+(\.[0-9]+)?S"#

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
