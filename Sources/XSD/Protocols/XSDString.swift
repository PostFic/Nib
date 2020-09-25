public protocol XSDString:
	ExpressibleByStringLiteral,
	LosslessStringConvertible,
	XSDValue
where Self.StringLiteralType == String {

	static func ==<S: XSDString>(
		lhs: Self,
		rhs: S
	) -> Bool

	static func !=<S: XSDString>(
		lhs: Self,
		rhs: S
	) -> Bool

	init?(
		_ value: String
	)

}

public extension XSDString {

	func hash(
		into hasher: inout Hasher
	) { hasher.combine(description) }

	@inlinable
	init(
		stringLiteral value: Self.StringLiteralType
	) { self.init(value)! }

	@inlinable
	static func ===(
		lhs: Self,
		rhs: Self
	) -> Bool { lhs == rhs }

	@inlinable
	static func ==<S: XSDString>(
		lhs: Self,
		rhs: S
	) -> Bool { lhs.description == rhs.description }

	@inlinable
	static func !=<S: XSDString>(
		lhs: Self,
		rhs: S
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
