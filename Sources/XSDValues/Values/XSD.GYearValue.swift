import XSD

extension XSD {

	/// A structure representing the XSD Date/time Seven‐property
	///   Model.
	public struct GYearValue:
		XSDDate·timeSevenPropertyModelValue
	{

		public let ·day·: XSD.Integer? = nil

		public let ·hour·: XSD.Integer? = nil

		public let ·minute·: XSD.Integer? = nil

		public let ·month·: XSD.Integer? = nil

		public let ·second·: XSD.DecimalNumber? = nil

		public let ·timezoneOffset·: XSD.Integer?

		public let ·year·: XSD.Integer?

		public init (
			_ Yr: XSD.Integer,
			_ Tz: XSD.Integer? = nil
		) {
			if
				let tz = Tz,
				!(tz >= -840 && tz <= 840)
			{ fatalError("Expected an integer between -840 and 840 inclusive, but got \(tz).") }
			else {
				var yr = Yr
				var mo = 1 as XSD.Integer
				var da = 1 as XSD.Integer
				var hr = 0 as XSD.Integer
				var mi = 0 as XSD.Integer
				var se = 0 as XSD.DecimalNumber
				XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
				·year· = yr
				·timezoneOffset· = Tz
			}
		}

		public init? (
			year: XSD.Integer?,
			month: XSD.Integer? = nil,
			day: XSD.Integer? = nil,
			hour: XSD.Integer? = nil,
			minute: XSD.Integer? = nil,
			second: XSD.DecimalNumber? = nil,
			timezoneOffset: XSD.Integer?
		) {
			guard
				let Yr = year,
				month == nil,
				day == nil,
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
			{ self.init(Yr, timezoneOffset) }
		}

	}

}
