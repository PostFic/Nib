import XSD

public extension XSD {

	/// A `XSD.duYearFrag` and/or `XSD.duMonthFrag`, in order.
	///
	/// ````
	/// [12]   duYearMonthFrag ::= (duYearFrag duMonthFrag?) | duMonthFrag
	/// ````
	final class duYearMonthFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "[0-9]+Y([0-9]+M)?|[0-9]+M"

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
