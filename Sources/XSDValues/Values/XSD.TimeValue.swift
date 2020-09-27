import XSD

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct TimeValue:
		XSDDate·timeSevenPropertyModelValue
	{

		public let ·day·: XSD.Integer? = nil

		public let ·hour·: XSD.Integer?

		public let ·minute·: XSD.Integer?

		public let ·month·: XSD.Integer? = nil

		public let ·second·: XSD.DecimalNumber?

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer? = nil

		public init (
			_ Hr: XSD.Integer,
			_ Mi: XSD.Integer,
			_ Se: XSD.DecimalNumber,
			_ Tz: XSD.Integer? = nil
		) {
			if !(Hr >= 0 && Hr <= 24)
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
				var yr = 0 as XSD.Integer
				var mo = 1 as XSD.Integer
				var da = 1 as XSD.Integer
				var hr = Hr
				var mi = Mi
				var se = Se
				XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
				·hour· = hr
				·minute· = mi
				·second· = se
				·timezoneOffset· = Tz
			}
		}

		public init? (
			year: XSD.Integer? = nil,
			month: XSD.Integer? = nil,
			day: XSD.Integer? = nil,
			hour: XSD.Integer?,
			minute: XSD.Integer?,
			second: XSD.DecimalNumber?,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year == nil,
				month == nil,
				day == nil,
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
			{ self.init(Hr, Mi, Se, timezoneOffset) }
		}

	}

}
