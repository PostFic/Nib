import XSD

public protocol XSDNumberConvertible {

	static postfix func ◊<N: XSDNumber>(
		operand: Self
	) -> N

	static postfix func ◊?<N: XSDNumber>(
		operand: Self
	) -> N?

}

public extension XSDNumberConvertible {

	@inlinable
	static postfix func ◊<N: XSDNumber>(
		operand: Self
	) -> N { (operand◊?)! }

}

public extension XSDNumberConvertible where Self: BinaryInteger {

	@inlinable
	static postfix func ◊?<N: XSDNumber>(
		operand: Self
	) -> N? { return N(exactly: operand) }

}

