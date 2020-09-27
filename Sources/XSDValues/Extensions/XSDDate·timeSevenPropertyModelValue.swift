import XSD

public extension XSDDate·timeSevenPropertyModelValue {

	var ·timeOnTimeline·: XSD.DecimalNumber
	{ return XSD.·timeOnTimeline·(self) }

	init (
		from timeOnTimeline: XSD.DecimalNumber,
		timezoneOffset tz: XSD.Integer? = nil
	) {
		var yr: XSD.Integer = 0
		var mo: XSD.Integer = 0
		var da: XSD.Integer = 0
		var hr: XSD.Integer = 0
		var mi: XSD.Integer = 0
		var se = timeOnTimeline
		XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
		self = XSD.·newDateTime·(yr, mo, da, hr, mi, se, tz)
	}

	static func + (
		lhs: Self,
		rhs: XSD.DurationValue
	) -> Self
	{ XSD.·dateTimePlusDuration·(rhs, lhs) }

	static func + <D> (
		lhs: Self,
		rhs: D
	) -> Self
	where D: XSDDurationValue {
		return XSD.·dateTimePlusDuration·(
			XSD.DurationValue(
				sign: rhs.·months· < 0 || rhs.·seconds· < 0 ? .minus : .plus,
				months: rhs.·months·,
				seconds: rhs.·seconds·
			),
			lhs
		)
	}

}
