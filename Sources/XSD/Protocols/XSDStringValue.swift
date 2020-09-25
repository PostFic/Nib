public protocol XSDStringValue:
	ExpressibleByStringLiteral,
	LosslessStringConvertible,
	XSDValue
where Self.StringLiteralType == String {

	static func == <S> (
		lhs: Self,
		rhs: S
	) -> Bool
	where S: XSDStringValue

	static func != <S> (
		lhs: Self,
		rhs: S
	) -> Bool
	where S: XSDStringValue

	init? (
		_ value: String
	)

}

public extension XSDStringValue {

	func hash (
		into hasher: inout Hasher
	) { hasher.combine(description) }

	@inlinable
	init (
		stringLiteral value: Self.StringLiteralType
	) { self.init(value)! }

	@inlinable
	static func === (
		lhs: Self,
		rhs: Self
	) -> Bool
	{ lhs == rhs }

	@inlinable
	static func == <S> (
		lhs: Self,
		rhs: S
	) -> Bool
	where S: XSDStringValue
	{ lhs.description == rhs.description }

	@inlinable
	static func != <S> (
		lhs: Self,
		rhs: S
	) -> Bool
	where S: XSDStringValue
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
