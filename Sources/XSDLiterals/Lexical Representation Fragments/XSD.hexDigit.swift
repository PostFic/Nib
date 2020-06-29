import XSD

public extension XSD {

	/// A single hex (hexadecimal) digit.
	///
	/// ````
	/// [24]   hexDigit ::= [0-9a-fA-F]
	/// ````
	final class hexDigit: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9a-fA-F]"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
