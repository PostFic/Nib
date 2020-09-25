public protocol XSDBoolean:
	ExpressibleByBooleanLiteral
where Self.BooleanLiteralType == Bool {

	var bool: Bool { get }

	init?(
		_ value: Bool
	)

}

public extension XSDBoolean {

	@inlinable
	init(
		booleanLiteral value: Self.BooleanLiteralType
	) { self.init(value)! }

}
