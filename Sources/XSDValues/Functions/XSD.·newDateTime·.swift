import XSD

public extension XSD {

	/// Returns an `XSDDate·timeSevenPropertyModelValue` with property values as specified in the arguments.
	///
	///  +  parameters:
	///      +  Yr:
	///         An `XSD.Integer`, or `nil`.
	///      +  Mo:
	///         An `XSD.Integer` between 1 and 12 inclusive, or `nil`.
	///      +  Da:
	///         An `XSD.Integer` between 1 and 31 inclusive, or `nil`.
	///      +  Hr:
	///         An `XSD.Integer` between 0 and 24 inclusive, or `nil`.
	///      +  Mi:
	///         An `XSD.Integer` between 0 and 59 inclusive, or `nil`.
	///      +  Se:
	///         A `XSD.DecimalNumber` greater than or equal to 0 and less than 60, or `nil`.
	///      +  Tz:
	///         An `XSD.Integer` between -840 and 840 inclusive, or `nil`.
	///
	///  +  returns:
	///     A `XSDDate·timeSevenPropertyModelValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#p-setDTFromRaw>
	///
	///  +  note:
	///     The XSD specification specifies that `·newDateTime·` should use a year of 1 when `Yr` is absent; however, this effectively prohibits `--02-29` as a `XSD.GMonthDayValue`, as year 1 is not a leapyear.
	///     Nib instead supplies a year of 0, which avoids this problem.
	@inlinable
	static func ·newDateTime· <D7M> (
		_ Yr: XSD.Integer?,
		_ Mo: XSD.Integer?,
		_ Da: XSD.Integer?,
		_ Hr: XSD.Integer?,
		_ Mi: XSD.Integer?,
		_ Se: XSD.DecimalNumber?,
		_ Tz: XSD.Integer?
	) -> D7M
	where D7M: XSDDate·timeSevenPropertyModelValue {
		return D7M(
			year: Yr,
			month: Mo,
			day: Da,
			hour: Hr,
			minute: Mi,
			second: Se,
			timezoneOffset: Tz
		)!
	}

}
