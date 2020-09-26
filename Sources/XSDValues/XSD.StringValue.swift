import XSD
import XSDLiterals

extension XSD {

	public struct StringValue:
		XSDCanonicalMappable,
		XSDStringValue
	{

		public typealias LexicalRepresentation = XSD.stringRep

		public let description: String

		public var ·canonicalMapping·: XSD.StringValue.LexicalRepresentation
		{ XSD.·stringCanonicalMap·(self) }

		public init (
			mapping literal: XSD.StringValue.LexicalRepresentation
		) { self = XSD.·stringLexicalMap·(literal) }

		public init (
			_ literal: XSD.StringValue.LexicalRepresentation
		) {
			description = String(
				describing: literal
			)
		}

	}

}
