import XSD

public protocol XSDLiteral:
	BidirectionalCollection,
	XSDAtomicValue
where Element == Character, SubSequence: XSDLiteral {

	var stringValue: String { get }

	init(_ description: String)

	init<Literal: XSDLiteral>(literal value: Literal)

	func split(grouping numberOfCharacters: Int) -> UnfoldSequence<Substring, Substring>

}

public extension XSDLiteral {

	var stringValue: String {
		return String(describing: self)
	}

	init<Literal: XSDLiteral>(literal value: Literal) {
		self.init(value.stringValue)
	}

	func split(grouping numberOfCharacters: Int) -> UnfoldSequence<Substring, Substring> {
		return sequence(state: Substring(stringValue)) { remaining in
			if remaining.isEmpty {
				return nil
			}
			let result = remaining.prefix(numberOfCharacters)
			remaining = remaining.dropFirst(numberOfCharacters)
			return result
		}
	}

	static func ☆<Literal: XSDLiteral>(lhs: Self, rhs: Literal.Type) -> Literal {
		return rhs.init(literal: lhs)
	}

}
