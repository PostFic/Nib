public protocol XSDString:
	ExpressibleByStringLiteral
where Self.StringLiteralType == String {

	init?(
		_ value: String
	)

}

public extension XSDString {

	@inlinable
	init(
		stringLiteral value: Self.StringLiteralType
	) { self.init(value)! }

}
