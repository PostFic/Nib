public protocol XSDDate·timeSevenPropertyModel:
	Strideable,
	XSDValue
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

	static func ==<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool

	static func !=<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool

	static func <<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool

	static func <=<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool

	static func ><D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool

	static func >=<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool

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

	func hash(
		into hasher: inout Hasher
	) {
		hasher.combine(·year·)
		hasher.combine(·month·)
		hasher.combine(·day·)
		hasher.combine(·hour·)
		hasher.combine(·minute·)
		hasher.combine(·second·)
		hasher.combine(·timezoneOffset·)
	}

	static func ===(
		lhs: Self,
		rhs: Self
	) -> Bool {
		guard
			lhs.·year· == rhs.·year·,
			lhs.·month· == rhs.·month·,
			lhs.·day· == rhs.·day·,
			lhs.·hour· == rhs.·hour·,
			lhs.·minute· == rhs.·minute·,
			lhs.·second· == rhs.·second·,
			lhs.·timezoneOffset· == rhs.·timezoneOffset·
		else { return false }
		return true
	}

	static func ==<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { lhs.·timeOnTimeline· == rhs.·timeOnTimeline· }

	static func ~=(
		lhs: Self,
		rhs: Self
	) -> Bool {
		return (
			lhs.·timezoneOffset· == nil ? rhs.·timezoneOffset· == nil : rhs.·timezoneOffset· != nil
		) && lhs.·timeOnTimeline· == rhs.·timeOnTimeline·
	}

	@inlinable
	static func !=<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { !(lhs == rhs) }

	@inlinable
	static func <<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { lhs.·timeOnTimeline· < rhs.·timeOnTimeline· }

	@inlinable
	static func <=<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { lhs < rhs || lhs == rhs }

	@inlinable
	static func ><D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { !(lhs < rhs || lhs == rhs) }

	@inlinable
	static func >=<D7M: XSDDate·timeSevenPropertyModel>(
		lhs: Self,
		rhs: D7M
	) -> Bool { !(lhs < rhs) }

	static func »(
		lhs: Self,
		rhs: Self
	) -> Bool {
		if lhs.·timezoneOffset· == nil {
			guard
				let max = Self(
					year: lhs.·year·,
					month: lhs.·month·,
					day: lhs.·day·,
					hour: lhs.·hour·,
					minute: lhs.·minute·,
					second: lhs.·second·,
					timezoneOffset: 840
				)
			else { return false }
			if rhs.·timezoneOffset· == nil {
				guard
					let otherMin = Self(
						year: lhs.·year·,
						month: lhs.·month·,
						day: lhs.·day·,
						hour: lhs.·hour·,
						minute: lhs.·minute·,
						second: lhs.·second·,
						timezoneOffset: -840
					)
				else { return false }
				return max.·timeOnTimeline· < otherMin.·timeOnTimeline·
			} else { return max.·timeOnTimeline· < rhs.·timeOnTimeline· }
		} else if rhs.·timezoneOffset· == nil {
			guard
				let otherMin = Self(
					year: lhs.·year·,
					month: lhs.·month·,
					day: lhs.·day·,
					hour: lhs.·hour·,
					minute: lhs.·minute·,
					second: lhs.·second·,
					timezoneOffset: -840
				)
			else { return false }
			return lhs.·timeOnTimeline· < otherMin.·timeOnTimeline·
		} else { return lhs.·timeOnTimeline· < rhs.·timeOnTimeline· }
	}

}
