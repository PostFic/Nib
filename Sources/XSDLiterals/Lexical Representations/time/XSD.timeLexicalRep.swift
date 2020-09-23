import XSD
import XSDRegularExpressions

public extension XSD {

	/// A time with optional timezone offset, as in
	///   `XSD.dateTimeLexicalRep`.
	///
	/// ````
	/// [17]   timeLexicalRep ::= ((hourFrag ':' minuteFrag ':' secondFrag) | endOfDayFrag) timezoneFrag?
	/// ````
	class timeLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			(([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\\.[0-9]+)?|\
			(24:00:00(\\.0+)?))\
			(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
