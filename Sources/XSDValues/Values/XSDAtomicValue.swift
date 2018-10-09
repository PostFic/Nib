public protocol XSDAtomicValue:
	ExpressibleByStringLiteral,
	LosslessStringConvertible,
	TextOutputStreamable,
	XSDValue
{

	init?(_ description: String)

	init?<Literal: XSDLiteral>(literal value: Literal)

}

public extension XSDAtomicValue {

	func write<Target: TextOutputStream>(to target: inout Target) {
		target.write(stringValue)
	}

	init?<Literal: XSDLiteral>(literal value: Literal) {
		self.init(value.stringValue)
	}

}
