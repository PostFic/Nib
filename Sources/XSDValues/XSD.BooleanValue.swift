import XSD
import XSDLiterals

extension XSD {

	public enum BooleanValue:
		XSDBoolean,
		XSDCanonicalMappable
	{

		case `true`

		case `false`

		public typealias LexicalRepresentation = XSD.booleanRep

		public var bool: Bool { return self == .true }

		public var ·canonicalMapping·:
			XSD.BooleanValue.LexicalRepresentation
		{ return XSD.·booleanCanonicalMap·(self) }

		public init(
			_ value: Bool
		) { self = value ? .true : .false }

		public init(
			mapping literal: XSD.BooleanValue.LexicalRepresentation
		) { self = XSD.·booleanLexicalMap·(literal) }

	}

}
