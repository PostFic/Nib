public protocol XSDValue: Hashable {

	static func === <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func === (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func !== <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func !== (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ~= <V>(
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func ~= (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func !~= <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func !~= (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func » <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func » (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func !» <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func !» (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func « <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func « (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func !« <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func !« (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func › <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func › (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func !› <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func !› (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func ‹ <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func ‹ (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func !‹ <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func !‹ (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func «» <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func «» (
		lhs: Self,
		rhs: Self
	) -> Bool

	static func !«» <V>(
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue

	static func !«» (
		lhs: Self,
		rhs: Self
	) -> Bool

}

public extension XSDValue {

	@inlinable
	static func === <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ false }

	@inlinable
	static func !== <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ true }

	@inlinable
	static func !== (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs === rhs) }

	@inlinable
	static func ~= <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ false }

	@inlinable
	static func !~= <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ true }

	@inlinable
	static func !~= (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs ~= rhs) }

	@inlinable
	static func »<V>(
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ false }

	@inlinable
	static func !»<V>(
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ true }

	@inlinable
	static func !» (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs » rhs) }

	@inlinable
	static func « <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ false }

	@inlinable
	static func !« <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ true }

	@inlinable
	static func !« (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs « rhs) }

	@inlinable
	static func › <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ false }

	@inlinable
	static func › (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ lhs » rhs || lhs ~= rhs }

	@inlinable
	static func !› <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ true }

	@inlinable
	static func !› (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs › rhs) }

	@inlinable
	static func ‹ <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ false }

	@inlinable
	static func ‹ (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ lhs « rhs || lhs ~= rhs }

	@inlinable
	static func !‹ <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ true }

	@inlinable
	static func !‹ (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs ‹ rhs) }

	@inlinable
	static func «» <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ true }

	@inlinable
	static func «» (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs » rhs || lhs « rhs || lhs ~= rhs) }

	@inlinable
	static func !«» <V> (
		lhs: Self,
		rhs: V
	) -> Bool
	where V: XSDValue
	{ false }

	@inlinable
	static func !«» (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ !(lhs «» rhs) }

}

public extension XSDValue
where Self: Comparable {

	static func » (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ lhs < rhs }

	static func « (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ lhs > rhs }

}
