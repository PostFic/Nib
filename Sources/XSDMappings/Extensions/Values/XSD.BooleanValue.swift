import XSD
import XSDLiterals
import XSDValues

extension XSD.BooleanValue:
	XSDCanonicalMappable
{

	public typealias LexicalRepresentation = XSD.booleanRep

	@inlinable
	public var ·canonicalMapping·: XSD.BooleanValue.LexicalRepresentation
	{ return XSD.·booleanCanonicalMap·(self) }

	@inlinable
	public init (
		from decoder: Decoder
	) throws {
		try self = XSD.BooleanValue.LexicalRepresentation(
			from: decoder
		).·lexicalMapping·
	}

	@inlinable
	public init (
		mapping literal: XSD.BooleanValue.LexicalRepresentation
	) { self = XSD.·booleanLexicalMap·(literal) }

	@inlinable
	public func encode (
		to encoder: Encoder
	) throws {
		try ·canonicalMapping·.encode(
			to: encoder
		)
	}

}
