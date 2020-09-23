import XSD

public protocol XSDNumberConvertible {

	static func ◊<N: XSDNumber>(
		lhs: Self,
		rhs: N.Type
	) -> N

	static func ¿◊?<N: XSDNumber>(
		lhs: Self,
		rhs: N.Type
	) -> N?

	static postfix func ◊<N: XSDNumber>(
		operand: Self
	) -> N

	static postfix func ◊?<N: XSDNumber>(
		operand: Self
	) -> N?

}

public extension XSDNumberConvertible {

	@inlinable
	static func ◊<N: XSDNumber>(
		lhs: Self,
		rhs: N.Type
	) -> N { lhs◊ }

	@inlinable
	static func ¿◊?<N: XSDNumber>(
		lhs: Self,
		rhs: N.Type
	) -> N? { lhs◊? }

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

