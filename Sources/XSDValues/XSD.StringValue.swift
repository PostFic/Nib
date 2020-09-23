import XSD
import XSDLiterals

extension XSD {

	public struct StringValue: XSDCanonicalMappable {

		public typealias LexicalRepresentation = XSD.stringRep

		public let string: String

		public var canonicalMapping:
			XSD.StringValue.LexicalRepresentation
		{ return XSD.·stringCanonicalMap·(self) }

		public init(
			mapping literal: XSD.StringValue.LexicalRepresentation
		) { self = XSD.·stringLexicalMap·(literal) }

		public init(
			_ literal: XSD.StringValue.LexicalRepresentation
		) { string = String(describing: literal) }

	}

}
