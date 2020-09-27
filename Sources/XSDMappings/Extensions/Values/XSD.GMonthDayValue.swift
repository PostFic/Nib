import XSD
import XSDLiterals
import XSDValues

extension XSD.GMonthDayValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.gMonthDayLexicalRep

	public var ·canonicalMapping·: XSD.GMonthDayValue.LexicalRepresentation
	{ XSD.·gMonthDayCanonicalMap·(self) }

	public init (
		mapping literal: XSD.GMonthDayValue.LexicalRepresentation
	) { self = XSD.·gMonthDayLexicalMap·(literal) }

}
