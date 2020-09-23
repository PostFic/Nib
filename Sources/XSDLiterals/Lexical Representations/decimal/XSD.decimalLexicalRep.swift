import XSD
import XSDRegularExpressions

public extension XSD {

	/// A non‐empty finite‐length sequence of decimal digits
	///   separated by a period as a decimal indicator.
	/// An optional leading sign is allowed.
	/// If the sign is omitted, `"+"` is assumed.
	/// Leading and trailing zeroes are optional.
	/// If the fractional part is zero, the period and following
	///   zero(es) can be omitted.
	///
	/// ````
	/// [3]   decimalLexicalRep ::= decimalPtNumeral | noDecimalPtNumeral
	/// ````
	class decimalLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			(\\+|-)?([0-9]+(\\.[0-9]*)?|\
			\\.[0-9]+)
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
