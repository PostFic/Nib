import XSD
import XSDLiterals
import XSDValues

extension XSD.DoubleValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.doubleRep

	public var ·canonicalMapping·: XSD.DoubleValue.LexicalRepresentation
	{ XSD.·doubleCanonicalMap·(self) }

	public init (
		mapping literal: XSD.DoubleValue.LexicalRepresentation
	) { self = XSD.·doubleLexicalMap·(literal) }

}
