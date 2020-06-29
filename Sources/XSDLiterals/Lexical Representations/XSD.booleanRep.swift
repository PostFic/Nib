import XSD

public extension XSD {

	/// A set of four literals: `"true"`, `"false"`, `"1"`, and
	///   `"0"`.
	///
	/// ````
	/// [2]   booleanRep ::= 'true' | 'false' | '1' | '0'
	/// ````
	final class booleanRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "true|false|1|0"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
