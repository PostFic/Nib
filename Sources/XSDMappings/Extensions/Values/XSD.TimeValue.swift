import XSD
import XSDLiterals
import XSDValues

extension XSD.TimeValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.timeLexicalRep

	public var ·canonicalMapping·: XSD.TimeValue.LexicalRepresentation
	{ XSD.·timeCanonicalMap·(self) }

	public init (
		mapping literal: XSD.TimeValue.LexicalRepresentation
	) { self = XSD.·timeLexicalMap·(literal) }

}
