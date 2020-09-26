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

	static func +(
		lhs: Self,
		rhs: XSD.DurationValue
	) -> Self
	{ XSD.·dateTimePlusDuration·(rhs, lhs) }

	static func +<Duration: XSDDurationValue>(
		lhs: Self,
		rhs: Duration
	) -> Self {
		return XSD.·dateTimePlusDuration·(
			XSD.DurationValue(
				months: rhs.·months·,
				seconds: rhs.·seconds·
			)!,
			lhs
		)
	}

}
