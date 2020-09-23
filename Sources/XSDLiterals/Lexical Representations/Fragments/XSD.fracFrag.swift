import XSD

public extension XSD {

	/// The fractional part of a decimal number.
	///
	/// ````
	/// [48]   fracFrag ::= digit+
	/// ````
	final class fracFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
