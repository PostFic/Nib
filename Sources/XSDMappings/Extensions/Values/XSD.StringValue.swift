import XSD
import XSDLiterals
import XSDValues

extension XSD.StringValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.stringRep

	public var ·canonicalMapping·: XSD.StringValue.LexicalRepresentation
	{ XSD.·stringCanonicalMap·(self) }

	public init (
		mapping literal: XSD.StringValue.LexicalRepresentation
	) { self = XSD.·stringLexicalMap·(literal) }

}
