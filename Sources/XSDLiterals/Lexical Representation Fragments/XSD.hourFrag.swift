import XSD

public extension XSD {

	/// A two‐digit hour.
	///
	/// ````
	/// [59]   hourFrag ::= ([01] digit) | ('2' [0-3])
	/// ````
	final class hourFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[01][0-9]|2[0-3]"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
