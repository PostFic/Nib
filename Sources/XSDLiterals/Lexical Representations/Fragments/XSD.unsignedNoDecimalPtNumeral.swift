import XSD

public extension XSD {

	/// An unsigned integer.
	///
	/// ````
	/// [46]   unsignedNoDecimalPtNumeral ::= digit+
	/// ````
	final class unsignedNoDecimalPtNumeral: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
