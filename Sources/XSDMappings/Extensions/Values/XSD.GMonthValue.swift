import XSD
import XSDLiterals
import XSDValues

extension XSD.GMonthValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.gMonthLexicalRep

	public var ·canonicalMapping·: XSD.GMonthValue.LexicalRepresentation
	{ XSD.·gMonthCanonicalMap·(self) }

	public init (
		mapping literal: XSD.GMonthValue.LexicalRepresentation
	) { self = XSD.·gMonthLexicalMap·(literal) }

}
