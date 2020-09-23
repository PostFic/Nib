import Foundation
import XSD

public protocol XSDDate·timeSevenPropertyModel:
	Strideable,
	XSDDate·timeConvertible
where Stride == XSD.DecimalNumber {

	var ·day·: XSD.Integer? { get }

	var ·hour·: XSD.Integer? { get }

	var ·minute·: XSD.Integer? { get }

	var ·month·: XSD.Integer? { get }

	var ·second·: XSD.DecimalNumber? { get }

	var ·timezoneOffset·: XSD.Integer? { get }

	var ·year·: XSD.Integer? { get }

	init?<D7M: XSDDate·timeSevenPropertyModel>(
		_ d7m: D7M
	)

	init(
		from timeOnTimeline: XSD.DecimalNumber
	)

	init<N: XSDDate·timeConvertible>(
		from dt: N
	)

	init?(
		year: XSD.Integer?,
		month: XSD.Integer?,
		day: XSD.Integer?,
		hour: XSD.Integer?,
		minute: XSD.Integer?,
		second: XSD.DecimalNumber?,
		timezoneOffset: XSD.Integer?
	)

	static func +<Duration: XSDDuration>(
		lhs: Self,
		rhs: Duration
	) -> Self

}

public extension XSDDate·timeSevenPropertyModel {

	var ·timeOnTimeline·: XSD.DecimalNumber {
		return XSD.·timeOnTimeline·(self)
	}

	@inlinable
	init?<D7M: XSDDate·timeSevenPropertyModel>(
		_ d7m: D7M
	) {
		self.init(
			year: d7m.·year·,
			month: d7m.·month·,
			day: d7m.·day·,
			hour: d7m.·hour·,
			minute: d7m.·minute·,
			second: d7m.·second·,
			timezoneOffset: d7m.·timezoneOffset·
		)
	}

	init(from timeOnTimeline: XSD.DecimalNumber) {
		var yr: XSD.Integer = 0
		var mo: XSD.Integer = 0
		var da: XSD.Integer = 0
		var hr: XSD.Integer = 0
		var mi: XSD.Integer = 0
		var se = timeOnTimeline
		XSD.·normalizeSecond·(&yr, &mo, &da, &hr, &mi, &se)
		self = XSD.·newDateTime·(yr, mo, da, hr, mi, se, nil)
	}

	@inlinable
	init<N: XSDDate·timeConvertible>(
		from dt: N
	) { self.init(from: dt.·timeOnTimeline·) }

	@inlinable
	func advanced(
		by n: XSD.DecimalNumber
	) -> Self { Self(from: ·timeOnTimeline·.advanced(by: n)) }

	@inlinable
	func distance(
		to other: Self
	) -> XSD.DecimalNumber {
		return ·timeOnTimeline·.distance(to: other.·timeOnTimeline·)
	}

	static func ==<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { lhs.·timeOnTimeline· == rhs.·timeOnTimeline· }

	static func <<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { lhs.·timeOnTimeline· < rhs.·timeOnTimeline· }

	static func +(
		lhs: Self,
		rhs: XSD.DurationValue
	) -> Self { XSD.·dateTimePlusDuration·(rhs, lhs) }

	static func +<Duration: XSDDuration>(
		lhs: Self,
		rhs: Duration
	) -> Self {
		return XSD.·dateTimePlusDuration·(
			XSD.DurationValue(rhs.·months·, rhs.·seconds·),
			lhs
		)
	}

}
