public protocol XSDLexicallyRepresentable {

	associatedtype LexicalRepresentation: XSDLexicalRepresentation
	where LexicalRepresentation.Value == Self

	init(
		mapping literal: Self.LexicalRepresentation
	)

}
