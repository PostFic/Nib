import XSD

public extension XSD {

	/// Two consecutive hex digits representing a number between 0 and
	///   255.
	///
	/// ````
	/// [25]   hexOctet ::= hexDigit hexDigit
	/// ````
	final class hexOctet: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9a-fA-F]{2}"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
