import XSD
import XSDRegularExpressions

public extension XSD {

	/// A month/year combination with optional timezone offset, as in
	///   `XSD.dateTimeLexicalRep`.
	///
	/// ````
	/// [19]   gYearMonthLexicalRep ::= yearFrag '-' monthFrag timezoneFrag?
	/// ````
	class gYearMonthLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			-?([1-9][0-9]{3,}|0[0-9]{3})-(0[1-9]|1[0-2])\
			(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
