import XSD
import XSDLiterals
import XSDValues

extension XSD.GYearMonthValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.gYearMonthLexicalRep

	public var ·canonicalMapping·: XSD.GYearMonthValue.LexicalRepresentation
	{ XSD.·gYearMonthCanonicalMap·(self) }

	public init (
		mapping literal: XSD.GYearMonthValue.LexicalRepresentation
	) { self = XSD.·gYearMonthLexicalMap·(literal) }

}
