import XSD

public extension XSD {

	/// A two‐digit second.
	///
	/// ````
	/// [61]   secondFrag ::= ([0-5] digit) ('.' digit+)?
	/// ````
	final class secondFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"[0-5][0-9](\.[0-9]+)?"#

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
