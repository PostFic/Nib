import XSD

public protocol XSDValue:
	Codable,
	CustomStringConvertible,
	Hashable
{

	var stringValue: String { get }

	static func ☆<
		Literal: XSDLiteral
	>(lhs: Self, rhs: Literal.Type) -> Literal

	static func ☆?<
		AtomicValue: XSDAtomicValue
	>(lhs: Self, rhs: AtomicValue.Type) -> AtomicValue?

}

public extension XSDAtomicValue {

	var description: String {
		return stringValue
	}

	static func ☆<
		Literal: XSDLiteral
	>(lhs: Self, rhs: Literal.Type) -> Literal {
		return rhs.init(lhs.stringValue)
	}

	static func ☆?<
		AtomicValue: XSDAtomicValue
	>(lhs: Self, rhs: AtomicValue.Type) -> AtomicValue? {
		return rhs.init(lhs.stringValue)
	}

}
