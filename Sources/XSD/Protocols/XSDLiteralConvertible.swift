public protocol XSDLiteralConvertible {

	static postfix func ◊<L: XSD.Literal>(
		operand: Self
	) -> L

	static postfix func ◊?<L: XSD.Literal>(
		operand: Self
	) -> L?

}

public extension XSDLiteralConvertible {

	@inlinable
	static postfix func ◊<L: XSD.Literal>(
		operand: Self
	) -> L { (operand◊?)! }

}

public extension XSDLiteralConvertible
	where Self: CustomStringConvertible
{

	@inlinable
	static postfix func ◊?<L: XSD.Literal>(
		operand: Self
	) -> L? { L(String(describing: operand)) }

}
