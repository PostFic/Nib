import XSD

public protocol XSDBinaryDataConvertible {

	static postfix func ◊<BD: XSDBinaryData>(
		operand: Self
	) -> BD

	static postfix func ◊?<BD: XSDBinaryData>(
		operand: Self
	) -> BD?

}

public extension XSDBinaryDataConvertible {

	@inlinable
	static postfix func ◊<BD: XSDBinaryData>(
		operand: Self
	) -> BD { (operand◊?)! }

}

public extension XSDBinaryDataConvertible where
	Self: Sequence,
	Self.Element == XSD.BinaryOctet
{

	@inlinable
	static postfix func ◊<BD: XSDBinaryData>(
		operand: Self
	) -> BD { BD(operand) }

}

