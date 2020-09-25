import XSD

public extension XSD {

	/// A day with optional timezone offset, as in
	///   `XSD.dateTimeLexicalRep`.
	///
	/// ````
	/// [22]   gDayLexicalRep ::= '---' dayFrag timezoneFrag?
	/// ````
	class gDayLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"---(0[1-9]|[12][0-9]|3[01])(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?"#

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
