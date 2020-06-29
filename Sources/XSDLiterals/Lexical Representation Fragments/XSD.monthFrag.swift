import XSD

public extension XSD {

	/// A two‐digit month.
	///
	/// ````
	/// [57]   monthFrag ::= ('0' [1-9]) | ('1' [0-2])
	/// ````
	final class monthFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "0[1-9]|1[0-2]"

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
