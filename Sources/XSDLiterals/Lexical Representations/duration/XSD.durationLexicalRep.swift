import XSD

public extension XSD {

	/// One or more of a `XSD.duYearFrag`, `XSD.duMonthFrag`,
	///   `XSD.duDayFrag`, `XSD.duHourFrag`, `XSD.duMinuteFrag`, and/or
	///   `XSD.duSecondFrag`, in order, with letters `"P"` and `"T"`
	///   (and perhaps a "`-`") where appropriate.
	///
	/// ````
	/// [15]   durationLexicalRep ::= '-'? 'P' ((duYearMonthFrag duDayTimeFrag?) | duDayTimeFrag)
	/// ````
	///
	///  +  note:
	///     The XSD specification gives an incorrect regex: The seconds
	///       component is allowed to have a leading decimal.
	///     Nib provides the correct implementation (but note that
	///       durations with a leading decimal in their seconds value
	///       may not be interoperable).
	class durationLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			-?P((([0-9]+Y([0-9]+M)?([0-9]+D)?\
			|([0-9]+M)([0-9]+D)?\
			|([0-9]+D)\
			)\
			(T(([0-9]+H)([0-9]+M)?\
			(([0-9]+|[0-9]+\\.[0-9]*|\\.[0-9]+)S)?\
			|([0-9]+M)(([0-9]+|[0-9]+\\.[0-9]*|\\.[0-9]+)S)?\
			|(([0-9]+|[0-9]+\\.[0-9]*|\\.[0-9]+)S)\
			)\
			)?\
			)\
			|(T(([0-9]+H)([0-9]+M)?\
			(([0-9]+|[0-9]+\\.[0-9]*|\\.[0-9]+)S)?\
			|([0-9]+M)(([0-9]+|[0-9]+\\.[0-9]*|\\.[0-9]+)S)?\
			|(([0-9]+|[0-9]+\\.[0-9]*|\\.[0-9]+)S)\
			)\
			)\
			)
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
