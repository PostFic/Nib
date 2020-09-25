import XSD

public extension XSD {

	///  A `XSD.dateTimeLexicalRep` with required `XSD.timezoneFrag`.
	///
	/// ####  Constraint: Day‐of‐month Values  ####
	///
	/// The `day` value must be no more than 30 if `month` is one
	///   of 4, 6, 9, or 11; no more than 28 if `month` is 2 and
	///   `year` is not divisible by 4, or is divisible by 100 but
	///   not by 400; and no more than 29 if `month` is 2 and
	///   `year` is divisible by 400, or by 4 but not by 100.
	///
	/// ````
	/// [44]   dateTimeStampLexicalRep ::= yearFrag '-' monthFrag '-' dayFrag 'T' ((hourFrag ':' minuteFrag ':' secondFrag) | endOfDayFrag) timezoneFrag    Constraint: Day‐of‐month Representations
	/// ````
	///
	/// ####  Constraint: Day‐of‐month Representations  ####
	///
	/// Within a `XSD.dateTimeStampLexicalRep`, a `XSD.dayFrag` must
	///   not begin with the digit `"3"` or be `"29"` unless the value
	///   to which it would map would satisfy the value constraint on
	///   `day` values (“Constraint: Day‐of‐month Values”) given above.
	///
	///  +  note:
	///     The constraint on `XSD.dateTimeStampLexicalRep` cannot be
	///       enforced through instance initialization checks alone.
	class dateTimeStampLexicalRep: XSD.dateTimeLexicalRep {

		@XSD.RegularExpression.Wrapper
		private static var pattern = #"-?([1-9][0-9]{3,}|0[0-9]{3})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])T(([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](\.[0-9]+)?|(24:00:00(\.0+)?))(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))"#

		public class override var ·lexicalSpace·: XSD.RegularExpression
		{ return $pattern }

	}

}
