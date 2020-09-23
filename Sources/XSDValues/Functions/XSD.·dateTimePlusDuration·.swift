import XSD

public extension XSD {

	/// Adds a `XSD.DurationValue` to a
	///   `XSDDate·timeSevenPropertyModel`, producing another
	///   `XSDDate·timeSevenPropertyModel`.
	///
	///  +  parameters:
	///      +  du:
	///         A `XSD.DurationValue`.
	///      +  dt:
	///         A `XSDDate·timeSevenPropertyModel`.
	///
	///  +  returns:
	///     A `XSDDate·timeSevenPropertyModel`.
	///
	/// <https://www.w3.org/TR/xmlschema11-2/#vp-dt-dateTimePlusDuration>
	@inlinable
	static func ·dateTimePlusDuration·<
		D7M: XSDDate·timeSevenPropertyModel
	>(
		_ du: XSD.DurationValue,
		_ dt: D7M
	) -> D7M {
		var yr = dt.·year· ?? 1
		var mo = dt.·month· ?? 1
		var da = dt.·day· ?? 1
		var hr = dt.·hour· ?? 0
		var mi = dt.·minute· ?? 0
		var se = dt.·second· ?? 0
		mo += du.·months·
		XSD.·normalizeMonth·(&yr, &mo)
		let ·daysInMonth·yr，mo = XSD.·daysInMonth·(yr, mo)
		if da > ·daysInMonth·yr，mo { da = ·daysInMonth·yr，mo }
		se += du.·seconds·
		XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
		return XSD.·newDateTime·(
			dt.·year· == nil ? nil : yr,
			dt.·month· == nil ? nil : mo,
			dt.·day· == nil ? nil : da,
			dt.·hour· == nil ? nil : hr,
			dt.·minute· == nil ? nil : mi,
			dt.·second· == nil ? nil : se,
			dt.·timezoneOffset·
		)
	}

}
