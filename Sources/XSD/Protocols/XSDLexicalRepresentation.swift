public protocol XSDLexicalRepresentation:
	XSD.Literal
{

	associatedtype Value: XSDLexicallyRepresentable
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

public extension XSDLexicalRepresentation
where Self.Value: XSDCanonicalMappable {

	init (
		_ value: Self.Value
	) { self.init(value.·canonicalMapping·)! }

}
