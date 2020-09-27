import XSD
import XSDLiterals
import XSDValues

extension XSD.DateTimeValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.dateTimeLexicalRep

	public var ·canonicalMapping·: XSD.DateTimeValue.LexicalRepresentation
	{ XSD.·dateTimeCanonicalMap·(self) }

	public init (
		mapping literal: XSD.DateTimeValue.LexicalRepresentation
	) { self = XSD.·dateTimeLexicalMap·(literal) }

}
