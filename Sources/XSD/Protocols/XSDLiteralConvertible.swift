public protocol XSDLiteralConvertible {

	static postfix func ◊<L: XSD.Literal>(
		operand: Self
	) -> L

	static postfix func ◊?<L: XSD.Literal>(
		operand: Self
	) -> L?

}

public extension XSDLiteralConvertible {

	static postfix func ◊<L: XSD.Literal>(
		operand: Self
	) -> L { return (operand◊?)! }

}

public extension XSDLiteralConvertible
	where Self: CustomStringConvertible
{

	static postfix func ◊?<L: XSD.Literal>(
		operand: Self
	) -> L? { return L(String(describing: operand)) }

}
