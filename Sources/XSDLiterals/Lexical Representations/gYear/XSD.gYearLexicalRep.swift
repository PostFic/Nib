import XSD

public extension XSD {

	/// A year with optional timezone offset, as in
	///   `XSD.dateTimeLexicalRep`.
	///
	/// ````
	/// [20]   gYearLexicalRep ::= yearFrag timezoneFrag?
	/// ````
	class gYearLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"-?([1-9][0-9]{3,}|0[0-9]{3})(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?"#

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
