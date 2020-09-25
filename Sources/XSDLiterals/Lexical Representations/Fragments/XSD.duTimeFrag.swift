import XSD

public extension XSD {

	/// A `XSD.duHourFrag`, `XSD.duMinuteFrag`, and/or
	///   `XSD.duSecondFrag`, in order.
	///
	/// ````
	/// [13]   duTimeFrag ::= 'T' ((duHourFrag duMinuteFrag? duSecondFrag?) | (duMinuteFrag duSecondFrag?) | duSecondFrag)
	/// ````
	///
	///  +  note:
	///     The XSD specification gives an incorrect regex: The seconds
	///       component is allowed to have a leading decimal.
	///     Nib provides the correct implementation (but note that
	///       durations with a leading decimal in their seconds value
	///       may not be interoperable).
	final class duTimeFrag: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"T([0-9]+H([0-9]+M)?(([0-9]+|[0-9]+\.[0-9]*|\.[0-9]+)S)?|[0-9]+M(([0-9]+|[0-9]+\.[0-9]*|\.[0-9]+)S)?|([0-9]+|[0-9]+\.[0-9]*|\.[0-9]+)S)"#

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
