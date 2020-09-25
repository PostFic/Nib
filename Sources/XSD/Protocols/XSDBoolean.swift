public protocol XSDBoolean:
	ExpressibleByBooleanLiteral,
	XSDValue
where Self.BooleanLiteralType == Bool {

	var bool: Bool { get }

	init<B: XSDBoolean>(
		_ value: B
	)

	init(
		_ value: Bool
	)

	static func ==<B: XSDBoolean>(
		lhs: Self,
		rhs: B
	) -> Bool

	static func !=<B: XSDBoolean>(
		lhs: Self,
		rhs: B
	) -> Bool

}

public extension XSDBoolean {

	func hash(
		into hasher: inout Hasher
	) { hasher.combine(bool) }

	@inlinable
	init<B: XSDBoolean>(
		_ value: B
	) { self.init(value.bool) }

	@inlinable
	init(
		booleanLiteral value: Self.BooleanLiteralType
	) { self.init(value) }

	@inlinable
	static func ===(
		lhs: Self,
		rhs: Self
	) -> Bool { lhs == rhs }

	@inlinable
	static func ==<B: XSDBoolean>(
		lhs: Self,
		rhs: B
	) -> Bool { lhs.bool == rhs.bool }

	@inlinable
	static func !=<B: XSDBoolean>(
		lhs: Self,
		rhs: B
	) -> Bool { !(lhs == rhs) }

	@inlinable
	static func »(
		lhs: Self,
		rhs: Self
	) -> Bool { false }

	@inlinable
	static func «(
		lhs: Self,
		rhs: Self
	) -> Bool { false }

}
