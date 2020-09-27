import XSD
import XSDLiterals
import XSDValues

extension XSD.DecimalValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.decimalLexicalRep

	public var ·canonicalMapping·: XSD.DecimalValue.LexicalRepresentation
	{ XSD.·decimalCanonicalMap·(self) }

	public init (
		mapping literal: XSD.DecimalValue.LexicalRepresentation
	) { self = XSD.·decimalLexicalMap·(literal) }

}
