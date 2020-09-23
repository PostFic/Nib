import XSD

public protocol XSDLiteralConvertible {

	static func ◊<L: XSD.Literal>(
		lhs: Self,
		rhs: L.Type
	) -> L

	static func ¿◊?<L: XSD.Literal>(
		lhs: Self,
		rhs: L.Type
	) -> L?

	static postfix func ◊<L: XSD.Literal>(
		operand: Self
	) -> L

	static postfix func ◊?<L: XSD.Literal>(
		operand: Self
	) -> L?

}

public extension XSDLiteralConvertible
	where Self: CustomStringConvertible
{

	static func ◊<L: XSD.Literal>(
		lhs: Self,
		rhs: L.Type
	) -> L { return L(String(describing: lhs))! }

	static func ¿◊?<L: XSD.Literal>(
		lhs: Self,
		rhs: L.Type
	) -> L? { return L(String(describing: lhs)) }

	static postfix func ◊<L: XSD.Literal>(
		operand: Self
	) -> L { return L(String(describing: operand))! }

	static postfix func ◊?<L: XSD.Literal>(
		operand: Self
	) -> L? { return L(String(describing: operand)) }

}
