import XSD

public extension XSD {

	///  +  `XSD.yearFrag` is a numeral consisting of at least four
	///       decimal digits, optionally preceded by a minus sign;
	///       leading `"0"` digits are prohibited except to bring the
	///       digit count up to four.
	///     It represents the ·year· value.
	///
	///  +  Subsequent `"-"`, `"T"`, and `":"`, separate the various
	///       numerals.
	///
	///  +  `XSD.monthFrag`, `XSD.dayFrag`, `XSD.hourFrag`, and
	///       `XSD.minuteFrag` are numerals consisting of exactly two
	///       decimal digits.
	///     They represent the `month`, `day`, `hour`, and `minute`
	///       values respectively.
	///
	///  +  `XSD.secondFrag` is a numeral consisting of exactly two
	///       decimal digits, or two decimal digits, a decimal point,
	///       and one or more trailing digits.
	///     It represents the `second` value.
	///
	///  +  Alternatively, `XSD.endOfDayFrag` combines the
	///       `XSD.hourFrag`, `XSD.minuteFrag`, `XSD.secondFrag`, and
	///       their separators to represent midnight of the day, which
	///       is the first moment of the next day.
	///
	///  +  `XSD.timezoneFrag`, if present, specifies an offset between
	///       UTC and local time.
	///     Time zone offsets are a count of minutes (expressed in
	///       `XSD.timezoneFrag` as a count of hours and minutes) that
	///       are added or subtracted from UTC time to get the “local”
	///       time.
	///     `"Z"` is an alternative representation of the time zone
	///       offset `"00:00"`, which is, of course, zero minutes from
	///       UTC.
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
	/// [16]   dateTimeLexicalRep ::= yearFrag '-' monthFrag '-' dayFrag 'T' ((hourFrag ':' minuteFrag ':' secondFrag) | endOfDayFrag) timezoneFrag?    Constraint: Day‐of‐month Representations
	/// ````
	///
	/// ####  Constraint: Day‐of‐month Representations  ####
	///
	/// Within a `XSD.dateTimeLexicalRep`, a `XSD.dayFrag` must not
	///   begin with the digit `"3"` or be `"29"` unless the value to
	///   which it would map would satisfy the value constraint on
	///   `day` values (“Constraint: Day‐of‐month Values”) given above.
	///
	///  +  note:
	///     The constraint on `XSD.dateTimeLexicalRep` cannot be
	///       enforced through instance initialization checks alone.
	class dateTimeLexicalRep: XSD.Literal {

		@XSD.RegularExpression.Wrapper
		private static var pattern = """
			-?([1-9][0-9]{3,}|0[0-9]{3})\
			-(0[1-9]|1[0-2])\
			-(0[1-9]|[12][0-9]|3[01])\
			T(([01][0-9]|2[0-3]):\
			[0-5][0-9]:\
			[0-5][0-9](\\.[0-9]+)?|\
			(24:00:00(\\.0+)?))\
			(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?
			"""

		public class override var ·lexicalSpace·:
			XSD.RegularExpression
		{ return $pattern }

	}

}
