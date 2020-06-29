import XSD

public extension XSD {

	/// A day/month combination with optional timezone offset, as in
	///   `XSD.dateTimeLexicalRep`.
	///
	/// ####  Constraint: Day‐of‐month Values  ####
	///
	/// The `day` value must be no more than 30 if `month` is one of 4,
	///   6, 9, or 11, and no more than 29 if `month` is 2.
	///
	/// ````
	/// [21]   gMonthDayLexicalRep ::= '--' monthFrag '-' dayFrag timezoneFrag?    Constraint: Day‐of‐month Representations
	/// ````
	///
	/// ####  Constraint: Day‐of‐month Representations  ####
	///
	/// Within a `XSD.gMonthDayLexicalRep`, a `XSD.dayFrag` must not
	///   begin with the digit `"3"` or be `"29"` unless the value to
	///   which it would map would satisfy the value constraint on
	///   `day` values (“Constraint: Day‐of‐month Values”) given above.
	///
	///  +  note:
	///     The constraint on `XSD.gMonthDayLexicalRep` cannot be
	///       enforced through instance initialization checks alone.
	final class gMonthDayLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			--(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])\
			(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?
			"""

		public class override var lexicalSpace: XSD.RegularExpression {
			return $pattern
		}

	}

}
