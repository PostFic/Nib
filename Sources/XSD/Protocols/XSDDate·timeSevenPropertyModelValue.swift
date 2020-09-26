public protocol XSDDate·timeSevenPropertyModelValue:
	Strideable,
	XSDValue
where Stride == XSD.DecimalNumber {

	var ·day·: XSD.Integer?
	{ get }

	var ·hour·: XSD.Integer?
	{ get }

	var ·minute·: XSD.Integer?
	{ get }

	var ·month·: XSD.Integer?
	{ get }

	var ·second·: XSD.DecimalNumber?
	{ get }

	var ·timeOnTimeline·: XSD.DecimalNumber
	{ get }

	var ·timezoneOffset·: XSD.Integer?
	{ get }

	var ·year·: XSD.Integer?
	{ get }

	init? <D7M> (
		_ d7m: D7M
	) where D7M: XSDDate·timeSevenPropertyModelValue

	init (
		from timeOnTimeline: XSD.DecimalNumber,
		timezoneOffset tz: XSD.Integer?
	)

	init? (
		year: XSD.Integer?,
		month: XSD.Integer?,
		day: XSD.Integer?,
		hour: XSD.Integer?,
		minute: XSD.Integer?,
		second: XSD.DecimalNumber?,
		timezoneOffset: XSD.Integer?
	)

	static func == <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue

	static func != <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue

	static func < <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue

	static func <= <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue

	static func > <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue

	static func >= <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue

	static func + <D> (
		lhs: Self,
		rhs: D
	) -> Self
	where D: XSDDurationValue

}

public extension XSDDate·timeSevenPropertyModelValue {

	@inlinable
	init? <D7M> (
		_ d7m: D7M
	) where D7M: XSDDate·timeSevenPropertyModelValue {
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
	func advanced (
		by n: XSD.DecimalNumber
	) -> Self {
		return Self(
			from: ·timeOnTimeline·.advanced(by: n),
			timezoneOffset: self.·timezoneOffset·
		)
	}

	@inlinable
	func distance (
		to other: Self
	) -> XSD.DecimalNumber {
		return ·timeOnTimeline·.distance(
			to: other.·timeOnTimeline·
		)
	}

	func hash (
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

	static func === (
		lhs: Self,
		rhs: Self
	) -> Bool {
		if
			lhs.·year· == rhs.·year·,
			lhs.·month· == rhs.·month·,
			lhs.·day· == rhs.·day·,
			lhs.·hour· == rhs.·hour·,
			lhs.·minute· == rhs.·minute·,
			lhs.·second· == rhs.·second·,
			lhs.·timezoneOffset· == rhs.·timezoneOffset·
		{ return true }
		else
		{ return false }
	}

	static func == <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue
	{ lhs.·timeOnTimeline· == rhs.·timeOnTimeline· }

	static func ~= (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ (lhs.·timezoneOffset· == nil ? rhs.·timezoneOffset· == nil : rhs.·timezoneOffset· != nil) && lhs.·timeOnTimeline· == rhs.·timeOnTimeline· }

	@inlinable
	static func != <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue
	{ !(lhs == rhs) }

	@inlinable
	static func < <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue
	{ lhs.·timeOnTimeline· < rhs.·timeOnTimeline· }

	@inlinable
	static func <= <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue
	{ lhs < rhs || lhs == rhs }

	@inlinable
	static func > <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue
	{ !(lhs < rhs || lhs == rhs) }

	@inlinable
	static func >= <D7M> (
		lhs: Self,
		rhs: D7M
	) -> Bool
	where D7M: XSDDate·timeSevenPropertyModelValue
	{ !(lhs < rhs) }

	static func » (
		lhs: Self,
		rhs: Self
	) -> Bool {
		if lhs.·timezoneOffset· == nil {
			if let max = Self(
				year: lhs.·year·,
				month: lhs.·month·,
				day: lhs.·day·,
				hour: lhs.·hour·,
				minute: lhs.·minute·,
				second: lhs.·second·,
				timezoneOffset: 840
			) {
				if rhs.·timezoneOffset· == nil {
					if let otherMin = Self(
						year: lhs.·year·,
						month: lhs.·month·,
						day: lhs.·day·,
						hour: lhs.·hour·,
						minute: lhs.·minute·,
						second: lhs.·second·,
						timezoneOffset: -840
					)
					{ return max.·timeOnTimeline· < otherMin.·timeOnTimeline· }
					else
					{ return false }
				} else
				{ return max.·timeOnTimeline· < rhs.·timeOnTimeline· }
			} else
			{ return false }
		} else if rhs.·timezoneOffset· == nil {
			if let otherMin = Self(
				year: lhs.·year·,
				month: lhs.·month·,
				day: lhs.·day·,
				hour: lhs.·hour·,
				minute: lhs.·minute·,
				second: lhs.·second·,
				timezoneOffset: -840
			)
			{ return lhs.·timeOnTimeline· < otherMin.·timeOnTimeline· }
			else
			{ return false }
		} else
		{ return lhs.·timeOnTimeline· < rhs.·timeOnTimeline· }
	}

}
