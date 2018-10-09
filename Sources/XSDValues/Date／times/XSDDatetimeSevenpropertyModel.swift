import Foundation
import XSD

public protocol XSDDatetimeSevenpropertyModel:
	Comparable,
	XSDAtomicValue
{

	associatedtype Year: XSDInteger

	associatedtype Month: XSDInteger

	associatedtype Day: XSDInteger

	associatedtype Hour: XSDInteger

	associatedtype Minute: XSDInteger

	associatedtype Second: XSDDecimalNumber

	associatedtype TimezoneOffset: XSDInteger

	var year: Year { get }

	var month: Month { get }

	var dateValue: Date { get }

	var day: Day { get }

	var decimalValue: Decimal { get }

	var distantFuture: Self { get }

	var distantPast: Self { get }

	var hour: Hour { get }

	var minute: Minute { get }

	var second: Second { get }

	var stringValue: String { get }

	var timeIntervalSince1970: TimeInterval { get }

	var timeIntervalSinceNow: TimeInterval { get }

	var timeIntervalSinceReferenceDate: TimeInterval { get }

	var timeIntervalSinceXSDReferenceDate: TimeInterval { get }

	var timezoneOffset: TimezoneOffset? { get }

	init()

	init<
		DatetimeSevenpropertyModel: XSDDatetimeSevenpropertyModel,
		Duration: XSDDatetimeSevenpropertyModel
	>(duration: Duration, since: DatetimeSevenpropertyModel)

	init<Duration: XSDDatetimeSevenpropertyModel>(durationSince1970: Duration)

	init<Duration: XSDDatetimeSevenpropertyModel>(durationSinceNow: Duration)

	init<Duration: XSDDatetimeSevenpropertyModel>(durationSinceReferenceDate: Duration)

	init<Duration: XSDDatetimeSevenpropertyModel>(durationSinceXSDReferenceDate: Duration)

	init<
		DatetimeSevenpropertyModel: XSDDatetimeSevenpropertyModel
	>(timeInterval: TimeInterval, since: DatetimeSevenpropertyModel)

	init(timeIntervalSince1970: TimeInterval)

	init(timeIntervalSinceNow: TimeInterval)

	init(timeIntervalSinceReferenceDate: TimeInterval)

	init(timeIntervalSinceXSDReferenceDate: TimeInterval)

	/// + Note:
	///   An extension defines default values for all parameters, but you must specify at least one.
	///   Default values match the XSD reference date of `1972-12-31T00:00:00`.
	init(
		year: Year,
		month: Month,
		day: Day,
		hour: Hour,
		minute: Minute,
		second: Second,
		timeInterval: TimeInterval?
	)

	mutating func addDuration<Duration: XSDDatetimeSevenpropertyModel>(_ duration: Duration)

	mutating func addTimeInterval(_ timeInterval: TimeInterval)

	func addingTimeInterval(_ timeInterval: TimeInterval) -> Self

	func addingDuration<Duration: XSDDatetimeSevenpropertyModel>(_ duration: Duration) -> Self

	func timeIntervalSince<
		DatetimeSevenpropertyModel: XSDDatetimeSevenpropertyModel
	>(_ date: DatetimeSevenpropertyModel) -> TimeInterval

	static var timeIntervalSinceReferenceDate: TimeInterval { get }

	static var timeIntervalBetween1970AndReferenceDate: TimeInterval { get }

	static func +<Duration: XSDDatetimeSevenpropertyModel>(lhs: Self, rhs: Duration) -> Self

	static func +=<Duration: XSDDatetimeSevenpropertyModel>(lhs: inout Self, rhs: Duration)

	static func -<Duration: XSDDatetimeSevenpropertyModel>(lhs: Self, rhs: Duration) -> Self

	static func -=<Duration: XSDDatetimeSevenpropertyModel>(lhs: inout Self, rhs: Duration)

	postfix static func ...(minimum: Self) -> PartialRangeFrom<Self>

	prefix static func ...(maximum: Self) -> PartialRangeThrough<Self>

	static func ...(minimum: Self, maximum: Self) -> ClosedRange<Self>

	prefix static func ..<(maximum: Self) -> PartialRangeUpTo<Self>

	static func ..<(minimum: Self, maximum: Self) -> Range<Self>

	static func ☆<Number: XSDNumber>(lhs: Self, rhs: Number.Type) throws -> Number

	static func ☆?<Number: XSDNumber>(lhs: Self, rhs: Number.Type) throws -> Number?

}

public extension XSDDatetimeSevenpropertyModel {

	init(
		year: Year = 1972,
		day: Day = 31,
		hour: Hour = 0,
		minute: Minute = 0,
		second: Second = 0,
		timeInterval: TimeInterval? = nil
	) {
		self.init(
			year: year,
			month: 12,
			day: day,
			hour: hour,
			minute: minute,
			second: second,
			timeInterval: timeInterval
		)
	}

	init(
		year: Year = 1972,
		month: Month,
		hour: Hour = 0,
		minute: Minute = 0,
		second: Second = 0,
		timeInterval: TimeInterval? = nil
	) {
		let day: Day
		switch month {
		case 2:
			if year % 4 == 0 {
				if
					let notLeapYear = Year(exactly: 100 as Int),
					year % notLeapYear == 0
				{
					if
						let exceptForLeapYear = Year(exactly: 400 as Int),
						year % exceptForLeapYear == 0
					{
						day = 29
					} else {
						day = 28
					}
				} else {
					day = 29
				}
			} else {
				 day = 28
			}
		case 4, 6, 9, 11:
			day = 30
		default:
			day = 31
		}
		self.init(
			year: year,
			month: month,
			day: day,
			hour: hour,
			minute: minute,
			second: second,
			timeInterval: timeInterval
		)
	}

	static func +<Duration: XSDDatetimeSevenpropertyModel>(lhs: Self, rhs: Duration) -> Self {
		var result = lhs
		result += rhs
		return result
	}

	static func -<Duration: XSDDatetimeSevenpropertyModel>(lhs: Self, rhs: Duration) -> Self {
		var result = lhs
		result -= rhs
		return result
	}

	static func ☆<Number: XSDNumber>(lhs: Self, rhs: Number.Type) -> Number {
		return rhs.init(truncating: NSDecimalNumber(decimal: lhs.decimalValue))
	}

	static func ☆?<Number: XSDNumber>(lhs: Self, rhs: Number.Type) -> Number? {
		return rhs.init(exactly: NSDecimalNumber(decimal: lhs.decimalValue))
	}

}
