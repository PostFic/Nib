import XSD
import XSDLiterals
import XSDValues

extension XSD.FloatValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.floatRep

	public var ·canonicalMapping·: XSD.FloatValue.LexicalRepresentation
	{ XSD.·floatCanonicalMap·(self) }

	public init (
		mapping literal: XSD.FloatValue.LexicalRepresentation
	) { self = XSD.·floatLexicalMap·(literal) }

}
