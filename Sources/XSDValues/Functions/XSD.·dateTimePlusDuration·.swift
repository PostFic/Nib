import XSD

public extension XSD {

	/// Adds a `XSD.DurationValue` to a `XSDDate·timeSevenPropertyModelValue`, producing another `XSDDate·timeSevenPropertyModelValue`.
	///
	///  +  parameters:
	///      +  du:
	///         A `XSD.DurationValue`.
	///      +  dt:
	///         A `XSDDate·timeSevenPropertyModelValue`.
	///
	///  +  returns:
	///     A `XSDDate·timeSevenPropertyModelValue`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dt-dateTimePlusDuration>
	///
	///  +  note:
	///     The XSD specification specifies that `·dateTimePlusDuration·` should use a year of 1 for `XSDDate·timeSevenPropertyModelValue` with no `·year·`; however, this effectively prohibits `--02-29` as a `XSD.GMonthDayValue`, as year 1 is not a leapyear.
	///     Nib instead supplies a year of 0, which avoids this problem.
	///     This may provide differing results from other implementations in certain cases.
	@inlinable
	static func ·dateTimePlusDuration· <D7M> (
		_ du: XSD.DurationValue,
		_ dt: D7M
	) -> D7M
	where D7M: XSDDate·timeSevenPropertyModelValue {
		var yr = dt.·year· ?? 0
		var mo = dt.·month· ?? 1
		var da = dt.·day· ?? 1
		var hr = dt.·hour· ?? 0
		var mi = dt.·minute· ?? 0
		var se = dt.·second· ?? 0
		mo += du.·months·
		XSD.·normalizeMonth·(&yr, &mo)
		let ·daysInMonth·yr，mo = XSD.·daysInMonth·(yr, mo)
		if da > ·daysInMonth·yr，mo
		{ da = ·daysInMonth·yr，mo }
		se += du.·seconds·
		XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
		return XSD.·newDateTime·(dt.·year· == nil ? nil : yr, dt.·month· == nil ? nil : mo, dt.·day· == nil ? nil : da, dt.·hour· == nil ? nil : hr, dt.·minute· == nil ? nil : mi, dt.·second· == nil ? nil : se, dt.·timezoneOffset·)
	}

}
