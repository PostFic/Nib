public protocol XSDValue: Hashable {

	associatedtype LexicalRepresentation: XSDLexicalRepresentation
	where LexicalRepresentation.Value == Self

	init(
		mapping literal: Self.LexicalRepresentation
	)

	init?(
		_ description: String
	)

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
	init? (
		_ description: String
	) {
		guard let literal: Self.LexicalRepresentation = description◊?
		else { return nil }
		self.init(
			mapping: literal
		)
	}

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
