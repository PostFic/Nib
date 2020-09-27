import XSD

extension XSD {

	public struct DurationValue:
		XSDDurationValue
	{

		public let ·months·: XSD.Integer

		public let ·seconds·: XSD.DecimalNumber

		public init? (
			months: XSD.Integer = 0,
			seconds: XSD.DecimalNumber = 0
		) {
			if months < 0 && seconds > 0 || months > 0 && seconds < 0
			{ return nil }
			else {
				self.init(
					sign: months < 0 || seconds < 0 ? .minus : .plus,
					months: months,
					seconds: seconds
				)
			}
		}

		public init (
			sign: FloatingPointSign,
			months: XSD.Integer,
			seconds: XSD.DecimalNumber
		) {
			if sign == .minus {
				·months· = -abs(months)
				·seconds· = -abs(seconds)
			} else {
				·months· = abs(months)
				·seconds· = abs(seconds)
			}
		}

	}

}
