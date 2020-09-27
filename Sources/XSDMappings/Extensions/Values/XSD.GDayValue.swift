import XSD
import XSDLiterals
import XSDValues

extension XSD.GDayValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.gDayLexicalRep

	public var ·canonicalMapping·: XSD.GDayValue.LexicalRepresentation
	{ XSD.·gDayCanonicalMap·(self) }

	public init (
		mapping literal: XSD.GDayValue.LexicalRepresentation
	) { self = XSD.·gDayLexicalMap·(literal) }

}
