import XSD

public extension XSDValue
where Self: XSDLexicallyRepresentable {

	@inlinable
	init? (
		_ description: String
	) {
		guard let literal = Self.LexicalRepresentation(description)
		else
		{ return nil }
		self.init(
			mapping: literal
		)
	}

}
