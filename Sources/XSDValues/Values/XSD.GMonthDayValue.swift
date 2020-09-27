import XSD

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct GMonthDayValue:
		XSDDate·timeSevenPropertyModelValue
	{

		public let ·day·: XSD.Integer?

		public let ·hour·: XSD.Integer? = nil

		public let ·minute·: XSD.Integer? = nil

		public let ·month·: XSD.Integer?

		public let ·second·: XSD.DecimalNumber? = nil

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer? = nil

		public init (
			_ Mo: XSD.Integer,
			_ Da: XSD.Integer,
			_ Tz: XSD.Integer? = nil
		) {
			if !(Mo >= 1 && Mo <= 12)
			{ fatalError("Expected an integer between 1 and 12 inclusive, but got \(Mo).") }
			else if !(Da >= 1 && Da <= 31)
			{ fatalError("Expected an integer between 1 and 31 inclusive, but got \(Da).") }
			else if
				let tz = Tz,
				!(tz >= -840 && tz <= 840)
			{ fatalError("Expected an integer between -840 and 840 inclusive, but got \(tz).") }
			else {
				var yr = 1 as XSD.Integer
				var mo = Mo
				var da = Da
				var hr = 0 as XSD.Integer
				var mi = 0 as XSD.Integer
				var se = 0 as XSD.DecimalNumber
				XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
				·month· = mo
				·day· = da
				·timezoneOffset· = Tz
			}
		}

		public init? (
			year: XSD.Integer? = nil,
			month: XSD.Integer?,
			day: XSD.Integer?,
			hour: XSD.Integer? = nil,
			minute: XSD.Integer? = nil,
			second: XSD.DecimalNumber? = nil,
			timezoneOffset: XSD.Integer?
		) {
			guard
				year == nil,
				let Mo = month,
				Mo >= 1 && Mo <= 12,
				let Da = day,
				Da >= 1 && Da <= 31,
				hour == nil,
				minute == nil,
				second == nil
			else
			{ return nil }
			if
				let tz = timezoneOffset,
				!(tz >= -840 && tz <= 840)
			{ return nil }
			else
			{ self.init(Mo, Da, timezoneOffset) }
		}

	}

}
