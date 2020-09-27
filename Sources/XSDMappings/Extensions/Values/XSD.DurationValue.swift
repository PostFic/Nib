import XSD
import XSDLiterals
import XSDValues

extension XSD.DurationValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.durationLexicalRep

	public var ·canonicalMapping·: XSD.DurationValue.LexicalRepresentation
	{ XSD.·durationCanonicalMap·(self) }

	public init (
		mapping literal: XSD.DurationValue.LexicalRepresentation
	) { self = XSD.·durationMap·(literal) }

}
