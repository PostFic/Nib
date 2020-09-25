import XSD

public extension XSD {

	/// The set of all decimal numerals with or without a decimal
	///   point, numerals in scientific (exponential) notation, and
	///   the literals `"INF"`, `"+INF"`, `"-INF"`, and `"NaN"`.
	///
	/// ````
	/// [4]   floatRep ::= noDecimalPtNumeral | decimalPtNumeral | scientificNotationNumeral | numericalSpecialRep
	/// ````
	class floatRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"(\+|-)?([0-9]+(\.[0-9]*)?|\.[0-9]+)([Ee](\+|-)?[0-9]+)?|(\+|-)?INF|NaN"#

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
