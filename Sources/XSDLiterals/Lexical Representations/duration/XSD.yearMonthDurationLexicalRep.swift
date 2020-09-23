import XSD

public extension XSD {

	/// A `XSD.durationLexicalRep` with `XSD.duDayFrag` and
	///   `XSD.duTimeFrag` disallowed.
	///
	/// ````
	/// [42]   yearMonthDurationLexicalRep ::= '-'? 'P' duYearMonthFrag
	/// ````
	class yearMonthDurationLexicalRep: XSD.durationLexicalRep {

		@XSD.RegularExpression.Wrapper
		private static var pattern = "-?P[0-9]+(Y([0-9]+M)?|M)"

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
