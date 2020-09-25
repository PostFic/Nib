public protocol XSDBooleanValue:
	ExpressibleByBooleanLiteral,
	XSDValue
where Self.BooleanLiteralType == Bool {

	var bool: Bool { get }

	init <B> (
		_ value: B
	) where B: XSDBooleanValue

	init(
		_ value: Bool
	)

	static func == <B> (
		lhs: Self,
		rhs: B
	) -> Bool
	where B: XSDBooleanValue

	static func != <B> (
		lhs: Self,
		rhs: B
	) -> Bool
	where B: XSDBooleanValue

}

public extension XSDBooleanValue {

	func hash (
		into hasher: inout Hasher
	) { hasher.combine(bool) }

	@inlinable
	init<B>(
		_ value: B
	) where B: XSDBooleanValue
	{ self.init(value.bool) }

	@inlinable
	init(
		booleanLiteral value: Self.BooleanLiteralType
	) { self.init(value) }

	@inlinable
	static func === (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ lhs == rhs }

	@inlinable
	static func == <B> (
		lhs: Self,
		rhs: B
	) -> Bool
	where B: XSDBooleanValue
	{ lhs.bool == rhs.bool }

	@inlinable
	static func != <B> (
		lhs: Self,
		rhs: B
	) -> Bool
	where B: XSDBooleanValue
	{ !(lhs == rhs) }

	@inlinable
	static func » (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ false }

	@inlinable
	static func « (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ false }

}
