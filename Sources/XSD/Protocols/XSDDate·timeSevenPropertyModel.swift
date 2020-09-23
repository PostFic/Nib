public protocol XSDDate·timeSevenPropertyModel:
	Strideable
where Stride == XSD.DecimalNumber {

	var ·day·: XSD.Integer? { get }

	var ·hour·: XSD.Integer? { get }

	var ·minute·: XSD.Integer? { get }

	var ·month·: XSD.Integer? { get }

	var ·second·: XSD.DecimalNumber? { get }

	var ·timeOnTimeline·: XSD.DecimalNumber { get }

	var ·timezoneOffset·: XSD.Integer? { get }

	var ·year·: XSD.Integer? { get }

	init?<D7M: XSDDate·timeSevenPropertyModel>(
		_ d7m: D7M
	)

	init(
		from timeOnTimeline: XSD.DecimalNumber
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

}
