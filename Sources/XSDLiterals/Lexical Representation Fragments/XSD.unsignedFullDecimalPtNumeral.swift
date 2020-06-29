import XSD

public extension XSD {

	/// An unsigned decimal number with both an integral and fractional
	///   part.
	///
	/// ````
	/// [50]   unsignedFullDecimalPtNumeral ::= unsignedNoDecimalPtNumeral '.' fracFrag
	/// ````
	final class unsignedFullDecimalPtNumeral: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"[0-9]+\.[0-9]+"#

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
