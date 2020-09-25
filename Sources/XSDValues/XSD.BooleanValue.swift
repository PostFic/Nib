import XSD
import XSDLiterals

extension XSD {

	public enum BooleanValue:
		String,
		XSDBoolean,
		XSDCanonicalMappable
	{

		case `true`

		case `false`

		public typealias LexicalRepresentation = XSD.booleanRep

		@inlinable
		public var bool: Bool { return self.rawValue == "true" }

		@inlinable
		public var ·canonicalMapping·:
			XSD.BooleanValue.LexicalRepresentation
		{ return XSD.·booleanCanonicalMap·(self) }

		@inlinable
		public init(
			_ value: Bool
		) { self = value ? .true : .false }

		@inlinable
		public init(
			from decoder: Decoder
		) throws { try self = XSD.BooleanValue.LexicalRepresentation(from: decoder).·lexicalMapping· }

		@inlinable
		public init(
			mapping literal: XSD.BooleanValue.LexicalRepresentation
		) { self = XSD.·booleanLexicalMap·(literal) }

		@inlinable
		public func encode(
			to encoder: Encoder
		) throws { try ·canonicalMapping·.encode(to: encoder) }

		public func hash(
			into hasher: inout Hasher
		) { hasher.combine(self.bool) }

	}

}
