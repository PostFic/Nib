public protocol XSDLexicalRepresentation:
	XSD.Literal
{

	associatedtype Value: XSDValue
	where Value.LexicalRepresentation == Self

	var ·lexicalMapping·: Self.Value
	{ get }

}

public extension XSDLexicalRepresentation {

	@inlinable
	var ·lexicalMapping·: Self.Value {
		return Self.Value(
			mapping: self
		)
	}

}
