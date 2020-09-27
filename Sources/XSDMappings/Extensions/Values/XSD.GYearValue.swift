import XSD
import XSDLiterals
import XSDValues

extension XSD.GYearValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.gYearLexicalRep

	public var ·canonicalMapping·: XSD.GYearValue.LexicalRepresentation
	{ XSD.·gYearCanonicalMap·(self) }

	public init (
		mapping literal: XSD.GYearValue.LexicalRepresentation
	) { self = XSD.·gYearLexicalMap·(literal) }

}
