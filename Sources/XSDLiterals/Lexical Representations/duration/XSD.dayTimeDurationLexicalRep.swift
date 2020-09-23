import XSD

public extension XSD {

	/// A `XSD.durationLexicalRep` with `XSD.duYearFrag` and
	///   `XSD.duMonthFrag` disallowed.
	///
	/// ````
	/// [43]   dayTimeDurationLexicalRep ::= '-'? 'P' duDayTimeFrag
	/// ````
	class dayTimeDurationLexicalRep: XSD.durationLexicalRep {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			-?P((([0-9]+D)\
			(T(([0-9]+H)([0-9]+M)?([0-9]+(\\.[0-9]+)?S)?\
			|([0-9]+M)([0-9]+(\\.[0-9]+)?S)?\
			|([0-9]+(\\.[0-9]+)?S)\
			)\
			)?\
			)\
			|(T(([0-9]+H)([0-9]+M)?([0-9]+(\\.[0-9]+)?S)?\
			|([0-9]+M)([0-9]+(\\.[0-9]+)?S)?\
			|([0-9]+(\\.[0-9]+)?S)\
			)\
			)\
			)
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
