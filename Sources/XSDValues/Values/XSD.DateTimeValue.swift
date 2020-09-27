import XSD

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct DateTimeValue:
		XSDDate·timeSevenPropertyModelValue
	{

		public let ·day·: XSD.Integer?

		public let ·hour·: XSD.Integer?

		public let ·minute·: XSD.Integer?

		public let ·month·: XSD.Integer?

		public let ·second·: XSD.DecimalNumber?

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer?

		public init (
			_ Yr: XSD.Integer,
			_ Mo: XSD.Integer,
			_ Da: XSD.Integer,
			_ Hr: XSD.Integer,
			_ Mi: XSD.Integer,
			_ Se: XSD.DecimalNumber,
			_ Tz: XSD.Integer? = nil
		) {
			if !(Mo >= 1 && Mo <= 12)
			{ fatalError("Expected an integer between 1 and 12 inclusive, but got \(Mo).") }
			else if !(Da >= 1 && Da <= 31)
			{ fatalError("Expected an integer between 1 and 31 inclusive, but got \(Da).") }
			else if !(Hr >= 0 && Hr <= 24)
			{ fatalError("Expected an integer between 0 and 24 inclusive, but got \(Hr).") }
			else if !(Mi >= 0 && Mi <= 59)
			{ fatalError("Expected an integer between 0 and 59 inclusive, but got \(Mi).") }
			else if !(Se >= 0 && Se < 60)
			{ fatalError("Expected a decimal number greater than or equal to 0 and less than 60, but got \(Se).") }
			else if
				let tz = Tz,
				!(tz >= -840 && tz <= 840)
			{ fatalError("Expected an integer between -840 and 840 inclusive, but got \(tz).") }
			else {
				var yr = Yr
				var mo = Mo
				var da = Da
				var hr = Hr
				var mi = Mi
				var se = Se
				XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
				·year· = yr
				·month· = mo
				·day· = da
				·hour· = hr
				·minute· = mi
				·second· = se
				·timezoneOffset· = Tz
			}
		}
		
		public init? (
			year: XSD.Integer?,
			month: XSD.Integer?,
			day: XSD.Integer?,
			hour: XSD.Integer?,
			minute: XSD.Integer?,
			second: XSD.DecimalNumber?,
			timezoneOffset: XSD.Integer?
		) {
			guard
				let Yr = year,
				let Mo = month,
				Mo >= 1 && Mo <= 12,
				let Da = day,
				Da >= 1 && Da <= 31,
				let Hr = hour,
				Hr >= 0 && Hr <= 24,
				let Mi = minute,
				Mi >= 0 && Mi <= 59,
				let Se = second,
				Se >= 0 && Se < 60
			else
			{ return nil }
			if
				let tz = timezoneOffset,
				!(tz >= -840 && tz <= 840)
			{ return nil }
			else
			{ self.init(Yr, Mo, Da, Hr, Mi, Se, timezoneOffset) }
		}

	}

}
