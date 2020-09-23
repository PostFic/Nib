import XSD

public extension XSD {

	/// The minimal set of special representations which do not have
	///   decimal equivalents.
	///
	/// ````
	/// [54]   minimalNumericalSpecialRep ::= 'INF' | '-INF' | 'NaN'
	/// ````
	final class minimalNumericalSpecialRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "-?INF|NaN"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
