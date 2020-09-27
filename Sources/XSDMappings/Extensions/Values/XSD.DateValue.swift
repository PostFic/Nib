import XSD
import XSDLiterals
import XSDValues

extension XSD.DateValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.dateLexicalRep

	public var ·canonicalMapping·: XSD.DateValue.LexicalRepresentation
	{ XSD.·dateCanonicalMap·(self) }

	public init (
		mapping literal: XSD.DateValue.LexicalRepresentation
	) { self = XSD.·dateLexicalMap·(literal) }

}
