public protocol XSDLiteralConvertible {

	static postfix func ◊<L>(
		operand: Self
	) -> L
	where L: XSD.Literal

	static postfix func ◊?<L>(
		operand: Self
	) -> L?
	where L: XSD.Literal

}

public extension XSDLiteralConvertible {

	@inlinable
	static postfix func ◊<L>(
		operand: Self
	) -> L
	where L: XSD.Literal
	{ (operand◊?)! }

}

public extension XSDLiteralConvertible
where Self: CustomStringConvertible {

	@inlinable
	static postfix func ◊? <L> (
		operand: Self
	) -> L?
	where L: XSD.Literal {
		return L(
			String(
				describing: operand
			)
		)
	}

}
