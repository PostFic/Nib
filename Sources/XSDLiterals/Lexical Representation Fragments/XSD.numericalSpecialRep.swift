import XSD

public extension XSD {

	/// The minimal set of special representations which do not have
	///   decimal equivalents.
	///
	/// ````
	/// [55]   numericalSpecialRep ::= '+INF' | minimalNumericalSpecialRep
	/// ````
	final class numericalSpecialRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"(\+|-)?INF|NaN"#

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
