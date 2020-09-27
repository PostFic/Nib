import XSD
import XSDLiterals
import XSDValues

extension XSD.HexBinaryValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.hexBinaryRep

	public var ·canonicalMapping·: XSD.HexBinaryValue.LexicalRepresentation
	{ XSD.·hexBinaryCanonical·(self) }

	public init (
		mapping literal: XSD.HexBinaryValue.LexicalRepresentation
	) { self = XSD.·hexBinaryMap·(literal) }

}
